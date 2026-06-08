import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/entities/store_entity.dart';
import '../../../../core/di/providers.dart';

class MapState {
  final List<StoreEntity> stores;
  final Position? userLocation;
  final bool isLoading;
  final String? errorMessage;
  final LocationPermission? permission;

  const MapState({
    this.stores = const [],
    this.userLocation,
    this.isLoading = false,
    this.errorMessage,
    this.permission,
  });

  MapState copyWith({
    List<StoreEntity>? stores,
    Position? userLocation,
    bool? isLoading,
    String? errorMessage,
    LocationPermission? permission,
    bool clearError = false,
  }) {
    return MapState(
      stores: stores ?? this.stores,
      userLocation: userLocation ?? this.userLocation,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      permission: permission ?? this.permission,
    );
  }
}

class MapNotifier extends Notifier<MapState> {
  @override
  MapState build() {
    Future.microtask(() => refresh());
    return const MapState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // 1. Request/check permissions and get user location
      await _fetchLocation();

      // 2. Fetch stores from repository
      final stores = await ref.read(mapRepositoryProvider).getStores();

      print('STORE COUNT: ${stores.length}');
      for (final store in stores) {
        print(store.storeName);
        print('Lat: ${store.latitude}');
        print('Lng: ${store.longitude}');
        print('Store ID: ${store.storeId}');
      }

      if (state.userLocation != null) {
        debugPrint('DEBUG: User location coordinates: Lat: ${state.userLocation!.latitude} | Lng: ${state.userLocation!.longitude}');
      } else {
        debugPrint('DEBUG: User location coordinates: null');
      }

      state = state.copyWith(
        stores: stores,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> _fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state = state.copyWith(permission: permission);
        throw Exception('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      state = state.copyWith(permission: permission);
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    } 

    state = state.copyWith(permission: permission);
    
    final position = await Geolocator.getCurrentPosition();
    state = state.copyWith(userLocation: position);
  }

  double calculateDistance(double storeLat, double storeLng) {
    if (state.userLocation == null) return 0.0;
    final distanceInMeters = Geolocator.distanceBetween(
      state.userLocation!.latitude,
      state.userLocation!.longitude,
      storeLat,
      storeLng,
    );
    return distanceInMeters / 1000.0; // Return in km
  }
}

final mapProvider = NotifierProvider<MapNotifier, MapState>(MapNotifier.new);
