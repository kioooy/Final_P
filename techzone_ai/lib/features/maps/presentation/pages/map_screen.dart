import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/map_provider.dart';
import '../../domain/entities/store_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _fitBounds();
  }

  void _fitBounds() {
    if (_mapController == null) return;
    final state = ref.read(mapProvider);
    if (state.stores.isEmpty) return;

    double minLat = state.stores.first.latitude;
    double maxLat = state.stores.first.latitude;
    double minLng = state.stores.first.longitude;
    double maxLng = state.stores.first.longitude;

    for (final store in state.stores) {
      if (store.latitude < minLat) minLat = store.latitude;
      if (store.latitude > maxLat) maxLat = store.latitude;
      if (store.longitude < minLng) minLng = store.longitude;
      if (store.longitude > maxLng) maxLng = store.longitude;
    }

    if (state.userLocation != null) {
      if (state.userLocation!.latitude < minLat) minLat = state.userLocation!.latitude;
      if (state.userLocation!.latitude > maxLat) maxLat = state.userLocation!.latitude;
      if (state.userLocation!.longitude < minLng) minLng = state.userLocation!.longitude;
      if (state.userLocation!.longitude > maxLng) maxLng = state.userLocation!.longitude;
    }

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        50.0, // padding
      ),
    );
  }

  void _showStoreDetails(BuildContext context, StoreEntity store, double distance) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLg)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                store.storeName,
                style: AppTextStyles.titleLg,
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.primary, size: 20),
                  const SizedBox(width: AppDimensions.spaceXs),
                  Expanded(
                    child: Text(
                      store.address,
                      style: AppTextStyles.bodyLg,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              Row(
                children: [
                  const Icon(Icons.directions_car, color: AppColors.onSurfaceVariant, size: 20),
                  const SizedBox(width: AppDimensions.spaceXs),
                  Text(
                    '${distance.toStringAsFixed(2)} km away',
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              Text(
                'Coordinates: ${store.latitude.toStringAsFixed(4)}, ${store.longitude.toStringAsFixed(4)}',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Locator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(mapProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: _buildBody(mapState),
    );
  }

  Widget _buildBody(MapState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: AppDimensions.spaceMd),
              Text(
                'Failed to load map data',
                style: AppTextStyles.titleMd,
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              Text(
                state.errorMessage!,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              ElevatedButton(
                onPressed: () => ref.read(mapProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.stores.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.storefront_outlined, size: 64, color: AppColors.onSurfaceVariant),
            const SizedBox(height: AppDimensions.spaceMd),
            Text(
              'No stores available',
              style: AppTextStyles.titleMd,
            ),
          ],
        ),
      );
    }

    // Determine initial camera position
    LatLng initialPosition;
    if (state.userLocation != null) {
      initialPosition = LatLng(state.userLocation!.latitude, state.userLocation!.longitude);
    } else {
      initialPosition = LatLng(state.stores.first.latitude, state.stores.first.longitude);
    }
    debugPrint('DEBUG: Initial camera target: Lat: ${initialPosition.latitude} | Lng: ${initialPosition.longitude}');

    // Build markers
    final Set<Marker> markers = {};
    
    // Add user marker if available
    if (state.userLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: LatLng(state.userLocation!.latitude, state.userLocation!.longitude),
          infoWindow: const InfoWindow(title: 'You are here'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    // Add store markers
    for (final store in state.stores) {
      final distance = ref.read(mapProvider.notifier).calculateDistance(store.latitude, store.longitude);
      
      markers.add(
        Marker(
          markerId: MarkerId(store.storeId),
          position: LatLng(store.latitude, store.longitude),
          infoWindow: InfoWindow(
            title: store.storeName,
            snippet: '${distance.toStringAsFixed(1)} km away',
            onTap: () => _showStoreDetails(context, store, distance),
          ),
          onTap: () => _showStoreDetails(context, store, distance),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
    
    print('MARKERS COUNT: ${markers.length}');

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 12.0,
      ),
      markers: markers,
      myLocationEnabled: state.userLocation != null,
      myLocationButtonEnabled: true,
      mapToolbarEnabled: false,
    );
  }
}
