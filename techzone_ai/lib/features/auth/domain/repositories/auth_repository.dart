import '../entities/user_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods in this repository return a `Future<T>` (or `Stream<T>`).
/// Upon failure (e.g., network issues, invalid credentials, missing data), 
/// methods will throw an `Exception` (such as `FirebaseAuthException` or a custom `Exception`).
/// The Presentation layer (Providers) is responsible for wrapping calls in `try/catch` blocks.
abstract class AuthRepository {
  /// Signs in the user with email and password.
  /// Throws an [Exception] if authentication fails.
  Future<UserEntity> login(String email, String password);

  /// Registers a new user and creates their Firestore record.
  /// Throws an [Exception] if registration fails.
  Future<UserEntity> register(
    String fullName,
    String email,
    String phone,
    String password,
  );

  /// Signs out the current user.
  /// Throws an [Exception] if sign out fails.
  Future<void> logout();

  /// Sends a password reset email.
  /// Throws an [Exception] if sending fails.
  Future<void> resetPassword(String email);

  /// Retrieves the currently authenticated user's profile from Firestore.
  /// Returns `null` if no user is signed in.
  /// Throws an [Exception] if network or parsing fails.
  Future<UserEntity?> getCurrentUser();
}
