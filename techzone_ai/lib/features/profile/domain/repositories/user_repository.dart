import '../../../../features/auth/domain/entities/user_entity.dart';
import 'dart:io';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class UserRepository {
  /// Retrieves a specific user's profile by ID.
  /// Throws an [Exception] if the user is not found or fetch fails.
  Future<UserEntity> getProfile(String userId);

  /// Updates the user's profile information.
  /// Throws an [Exception] if the update fails.
  Future<UserEntity> updateProfile(UserEntity user);

  /// Uploads a profile image and returns the download URL.
  /// Throws an [Exception] if the upload fails.
  Future<String> uploadProfileImage(String userId, File imageFile);

  /// Retrieves all users (typically for admin use).
  /// Throws an [Exception] if the operation fails.
  Future<List<UserEntity>> getAllUsers();
}
