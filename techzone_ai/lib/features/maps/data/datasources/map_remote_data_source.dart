import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/store_model.dart';

class MapRemoteDataSource {
  final FirebaseFirestore _firestore;

  MapRemoteDataSource(this._firestore);

  Future<List<StoreModel>> getStores() async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.stores)
          .get();
      
      debugPrint('DATASOURCE: Fetched ${snapshot.docs.length} store documents from Firestore.');
      for (var doc in snapshot.docs) {
        debugPrint('DATASOURCE: Doc ID: ${doc.id} => Data: ${doc.data()}');
      }

      return snapshot.docs.map((doc) => StoreModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get stores: $e');
    }
  }

  Future<StoreModel> updateStoreLocation(StoreModel store) async {
    try {
      await _firestore
          .collection(FirebaseConstants.stores)
          .doc(store.storeId)
          .set(store.toMap());
      return store;
    } catch (e) {
      throw Exception('Failed to update store location: $e');
    }
  }
}
