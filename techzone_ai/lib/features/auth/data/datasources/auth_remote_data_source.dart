import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource(this._firebaseAuth, this._firestore);

  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;
      final doc = await _firestore.collection(FirebaseConstants.users).doc(uid).get();
      if (!doc.exists) {
        throw Exception('User record not found in Firestore.');
      }
      
      debugPrint('LOGIN UID: $uid');
      debugPrint('LOGIN FIRESTORE DATA: ${doc.data()}');
      
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<UserModel> register(
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;

      final userModel = UserModel(
        uid: uid,
        fullName: fullName,
        email: email,
        phone: phone,
        address: '',
        role: 'customer',
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(FirebaseConstants.users)
          .doc(uid)
          .set(userModel.toMap());

      return userModel;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send reset password email: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;
      final doc = await _firestore.collection(FirebaseConstants.users).doc(user.uid).get();
      if (!doc.exists) return null;
      
      debugPrint('CURRENT USER UID: ${user.uid}');
      debugPrint('CURRENT USER FIRESTORE DATA: ${doc.data()}');
      
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }
}
