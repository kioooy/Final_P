import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../auth/data/models/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  UserRemoteDataSource(this._firestore, this._storage);

  Future<UserModel> getProfile(String userId) async {
    try {
      final doc = await _firestore.collection(FirebaseConstants.users).doc(userId).get();
      if (!doc.exists) throw Exception('User not found');
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  Future<UserModel> updateProfile(UserModel user) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(user.uid)
          .update(user.toMap());
      return user;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<String> uploadProfileImage(String userId, File imageFile) async {
    try {
      final ref = _storage.ref().child('profile_images').child('$userId.jpg');
      final uploadTask = await ref.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _firestore.collection(FirebaseConstants.users).get();
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }
}
