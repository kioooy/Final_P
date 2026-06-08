import '../entities/store_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class MapRepository {
  /// Retrieves all store locations.
  /// Throws an [Exception] if the fetch fails.
  Future<List<StoreEntity>> getStores();

  /// Updates the store location details.
  /// Throws an [Exception] if the update fails.
  Future<StoreEntity> updateStoreLocation(StoreEntity store);
}
