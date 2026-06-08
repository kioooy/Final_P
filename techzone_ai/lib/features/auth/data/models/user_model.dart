import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String role;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.role,
    this.profileImage,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    debugPrint('USERMODEL ROLE PARSED: ${map['role']}');
    return UserModel(
      uid: map['uid']?.toString() ?? '',
      fullName: map['fullName']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      phone: map['phone']?.toString() ?? '',
      address: map['address']?.toString() ?? '',
      role: map['role']?.toString() ?? '',
      profileImage: map['profileImage']?.toString(),
      createdAt: map['createdAt'] is Timestamp 
          ? (map['createdAt'] as Timestamp).toDate() 
          : (DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now()),
      updatedAt: map['updatedAt'] is Timestamp 
          ? (map['updatedAt'] as Timestamp).toDate() 
          : (map['updatedAt'] != null ? DateTime.tryParse(map['updatedAt'].toString()) : null),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'role': role,
      'profileImage': profileImage,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      fullName: entity.fullName,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      role: entity.role,
      profileImage: entity.profileImage,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      fullName: fullName,
      email: email,
      phone: phone,
      address: address,
      role: role,
      profileImage: profileImage,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phone,
    String? address,
    String? role,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
