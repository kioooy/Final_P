import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final model = await _remoteDataSource.login(email, password);
    return model.toEntity();
  }

  @override
  Future<UserEntity> register(
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    final model = await _remoteDataSource.register(fullName, email, phone, password);
    return model.toEntity();
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _remoteDataSource.resetPassword(email);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final model = await _remoteDataSource.getCurrentUser();
    return model?.toEntity();
  }
}
