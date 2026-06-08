import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    final models = await _remoteDataSource.getProducts();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<ProductEntity> getProductById(String productId) async {
    final model = await _remoteDataSource.getProductById(productId);
    return model.toEntity();
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final models = await _remoteDataSource.searchProducts(query);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<ProductEntity> createProduct(ProductEntity product) async {
    final model = ProductModel.fromEntity(product);
    final createdModel = await _remoteDataSource.createProduct(model);
    return createdModel.toEntity();
  }

  @override
  Future<ProductEntity> updateProduct(ProductEntity product) async {
    final model = ProductModel.fromEntity(product);
    final updatedModel = await _remoteDataSource.updateProduct(model);
    return updatedModel.toEntity();
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await _remoteDataSource.deleteProduct(productId);
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    final models = await _remoteDataSource.getProductsByCategory(categoryId);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    final models = await _remoteDataSource.getFeaturedProducts();
    return models.map((e) => e.toEntity()).toList();
  }
}
