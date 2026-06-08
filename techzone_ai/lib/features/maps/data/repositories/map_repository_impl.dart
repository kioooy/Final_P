import '../../domain/repositories/map_repository.dart';
import '../../domain/entities/store_entity.dart';
import '../models/store_model.dart';
import '../datasources/map_remote_data_source.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource _remoteDataSource;

  MapRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<StoreEntity>> getStores() async {
    final models = await _remoteDataSource.getStores();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<StoreEntity> updateStoreLocation(StoreEntity store) async {
    final model = StoreModel.fromEntity(store);
    final updatedModel = await _remoteDataSource.updateStoreLocation(model);
    return updatedModel.toEntity();
  }
}
