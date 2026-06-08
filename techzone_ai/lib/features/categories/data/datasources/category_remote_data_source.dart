import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/category_model.dart';

class CategoryRemoteDataSource {
  final FirebaseFirestore _firestore;

  CategoryRemoteDataSource(this._firestore);

  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await _firestore.collection(FirebaseConstants.categories).get();
      return snapshot.docs.map((doc) => CategoryModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  Future<CategoryModel> createCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection(FirebaseConstants.categories)
          .doc(category.categoryId)
          .set(category.toMap());
      return category;
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }

  Future<CategoryModel> updateCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection(FirebaseConstants.categories)
          .doc(category.categoryId)
          .update(category.toMap());
      return category;
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection(FirebaseConstants.categories).doc(categoryId).delete();
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }
}
