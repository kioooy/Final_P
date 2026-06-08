import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../../../core/di/providers.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ChatNotifier extends StreamNotifier<List<ChatMessageEntity>> {
  @override
  Stream<List<ChatMessageEntity>> build() {
    final user = ref.watch(authProvider).value;
    if (user == null) {
      return const Stream.empty();
    }
    return ref.read(chatRepositoryProvider).getMessages(user.uid);
  }

  Future<void> sendMessage(String messageText) async {
    final user = ref.read(authProvider).value;
    if (user == null) return;
    
    final userMessage = ChatMessageEntity(
      messageId: DateTime.now().millisecondsSinceEpoch.toString(),
      role: 'user',
      message: messageText.trim(),
      timestamp: DateTime.now(),
    );

    try {
      // Save user message
      await ref.read(chatRepositoryProvider).saveMessage(user.uid, userMessage);
      
      // Get AI response
      final aiResponseText = await ref.read(chatRepositoryProvider).generateAiResponse(messageText);
      
      final aiMessage = ChatMessageEntity(
        messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        role: 'ai',
        message: aiResponseText,
        timestamp: DateTime.now(),
      );
      
      // Save AI message
      await ref.read(chatRepositoryProvider).saveMessage(user.uid, aiMessage);
      
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<void> clearHistory() async {
    final user = ref.read(authProvider).value;
    if (user == null) return;
    
    try {
      await ref.read(chatRepositoryProvider).clearHistory(user.uid);
    } catch (e) {
      throw Exception('Failed to clear history: $e');
    }
  }
}

final chatProvider = StreamNotifierProvider<ChatNotifier, List<ChatMessageEntity>>(ChatNotifier.new);
