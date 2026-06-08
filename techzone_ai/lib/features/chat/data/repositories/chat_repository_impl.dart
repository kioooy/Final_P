import '../../domain/repositories/chat_repository.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../models/chat_message_model.dart';
import '../datasources/chat_remote_data_source.dart';
import '../datasources/ai_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;
  final AiRemoteDataSource _aiRemoteDataSource;

  ChatRepositoryImpl(this._remoteDataSource, this._aiRemoteDataSource);

  @override
  Stream<List<ChatMessageEntity>> getMessages(String userId) {
    return _remoteDataSource.getMessages(userId)
        .map((models) => models.map((e) => e.toEntity()).toList());
  }

  @override
  Future<void> saveMessage(String userId, ChatMessageEntity message) async {
    final model = ChatMessageModel.fromEntity(message);
    await _remoteDataSource.saveMessage(userId, model);
  }

  @override
  Future<void> clearHistory(String userId) async {
    await _remoteDataSource.clearHistory(userId);
  }

  @override
  Future<String> generateAiResponse(String messageText) async {
    return await _aiRemoteDataSource.generateAiResponse(messageText);
  }
}
