import 'package:equatable/equatable.dart';

class StoreEntity extends Equatable {
  final String storeId;
  final String storeName;
  final double latitude;
  final double longitude;
  final String address;

  const StoreEntity({
    required this.storeId,
    required this.storeName,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  StoreEntity copyWith({
    String? storeId,
    String? storeName,
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return StoreEntity(
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        storeId,
        storeName,
        latitude,
        longitude,
        address,
      ];
}
