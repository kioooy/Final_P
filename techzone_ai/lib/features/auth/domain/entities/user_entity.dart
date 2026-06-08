import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String role;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserEntity({
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

  UserEntity copyWith({
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
    return UserEntity(
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

  @override
  List<Object?> get props => [
        uid,
        fullName,
        email,
        phone,
        address,
        role,
        profileImage,
        createdAt,
        updatedAt,
      ];
}
