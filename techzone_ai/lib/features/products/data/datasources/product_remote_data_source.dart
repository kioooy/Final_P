import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final FirebaseFirestore _firestore;

  ProductRemoteDataSource(this._firestore);

  Future<List<ProductModel>> getProducts() async {
    try {
      final snapshot = await _firestore.collection(FirebaseConstants.products).get();
      return snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  Future<ProductModel> getProductById(String productId) async {
    try {
      final doc = await _firestore.collection(FirebaseConstants.products).doc(productId).get();
      if (!doc.exists) throw Exception('Product not found');
      return ProductModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.products)
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get products by category: $e');
    }
  }

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      // Assuming a high rating or review count dictates featured products
      final snapshot = await _firestore
          .collection(FirebaseConstants.products)
          .orderBy('rating', descending: true)
          .limit(10)
          .get();
      return snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get featured products: $e');
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // Simple prefix search using Firestore
      final snapshot = await _firestore
          .collection(FirebaseConstants.products)
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();
      return snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      await _firestore
          .collection(FirebaseConstants.products)
          .doc(product.productId)
          .set(product.toMap());
      return product;
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      await _firestore
          .collection(FirebaseConstants.products)
          .doc(product.productId)
          .update(product.toMap());
      return product;
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(FirebaseConstants.products).doc(productId).delete();
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
