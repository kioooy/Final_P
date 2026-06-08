import '../../domain/entities/store_entity.dart';

class StoreModel {
  final String storeId;
  final String storeName;
  final double latitude;
  final double longitude;
  final String address;

  const StoreModel({
    required this.storeId,
    required this.storeName,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      storeId: map['storeId']?.toString() ?? '',
      storeName: map['storeName']?.toString() ?? '',
      latitude: map['latitude'] is num ? (map['latitude'] as num).toDouble() : double.tryParse(map['latitude']?.toString() ?? '') ?? 0.0,
      longitude: map['longitude'] is num ? (map['longitude'] as num).toDouble() : double.tryParse(map['longitude']?.toString() ?? '') ?? 0.0,
      address: map['address']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'storeName': storeName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  factory StoreModel.fromEntity(StoreEntity entity) {
    return StoreModel(
      storeId: entity.storeId,
      storeName: entity.storeName,
      latitude: entity.latitude,
      longitude: entity.longitude,
      address: entity.address,
    );
  }

  StoreEntity toEntity() {
    return StoreEntity(
      storeId: storeId,
      storeName: storeName,
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  StoreModel copyWith({
    String? storeId,
    String? storeName,
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return StoreModel(
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}
