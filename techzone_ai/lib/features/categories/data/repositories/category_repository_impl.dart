import '../../domain/repositories/category_repository.dart';
import '../../domain/entities/category_entity.dart';
import '../models/category_model.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final models = await _remoteDataSource.getCategories();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<CategoryEntity> createCategory(CategoryEntity category) async {
    final model = CategoryModel.fromEntity(category);
    final createdModel = await _remoteDataSource.createCategory(model);
    return createdModel.toEntity();
  }

  @override
  Future<CategoryEntity> updateCategory(CategoryEntity category) async {
    final model = CategoryModel.fromEntity(category);
    final updatedModel = await _remoteDataSource.updateCategory(model);
    return updatedModel.toEntity();
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await _remoteDataSource.deleteCategory(categoryId);
  }
}
