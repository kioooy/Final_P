import 'dart:io';
import '../../domain/repositories/user_repository.dart';
import '../../../../features/auth/domain/entities/user_entity.dart';
import '../../../../features/auth/data/models/user_model.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> getProfile(String userId) async {
    final model = await _remoteDataSource.getProfile(userId);
    return model.toEntity();
  }

  @override
  Future<UserEntity> updateProfile(UserEntity user) async {
    final model = UserModel.fromEntity(user);
    final updatedModel = await _remoteDataSource.updateProfile(model);
    return updatedModel.toEntity();
  }

  @override
  Future<String> uploadProfileImage(String userId, File imageFile) async {
    return await _remoteDataSource.uploadProfileImage(userId, imageFile);
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final models = await _remoteDataSource.getAllUsers();
    return models.map((e) => e.toEntity()).toList();
  }
}
