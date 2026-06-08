import '../entities/chat_message_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class ChatRepository {
  /// Retrieves the chat history for a specific user.
  /// Throws an [Exception] if the fetch fails.
  Stream<List<ChatMessageEntity>> getMessages(String userId);

  /// Saves a new chat message to the user's history.
  /// Throws an [Exception] if saving fails.
  Future<void> saveMessage(String userId, ChatMessageEntity message);

  /// Clears the chat history for a specific user.
  /// Throws an [Exception] if clearing fails.
  Future<void> clearHistory(String userId);

  /// Generates an AI response for the given message text using Gemini API.
  /// Throws an [Exception] if generation fails.
  Future<String> generateAiResponse(String messageText);
}
