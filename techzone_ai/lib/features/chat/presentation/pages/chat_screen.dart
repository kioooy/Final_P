import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);
    // Clear input optimistically
    _messageController.clear();

    try {
      await ref.read(chatProvider.notifier).sendMessage(text);
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send: $e')),
        );
        // Restore text on failure
        _messageController.text = text;
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TechZone Support'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              try {
                await ref.read(chatProvider.notifier).clearHistory();
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to clear history: $e')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: chatState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  error.toString(),
                  style: AppTextStyles.bodyLg.copyWith(color: AppColors.error),
                ),
              ),
              data: (messages) {
                if (messages.isEmpty) {
                  return const Center(child: Text('Start a conversation...'));
                }

                // Assuming stream returns latest messages first, or we can reverse it
                // We'll reverse it so ListView with reverse: true works correctly.
                // Usually Firestore order by desc gives newest first.
                // If it's already newest first, we just pass it to ListView(reverse: true).
                final displayMessages = messages.toList();

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.all(AppDimensions.spaceMd),
                  itemCount: displayMessages.length,
                  itemBuilder: (context, index) {
                    final message = displayMessages[index];
                    final isUser = message.role.toLowerCase() == 'user';

                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: AppDimensions.spaceMd),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spaceLg,
                          vertical: AppDimensions.spaceMd,
                        ),
                        decoration: BoxDecoration(
                          color: isUser ? AppColors.primary : AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(AppDimensions.radiusLg),
                            topRight: const Radius.circular(AppDimensions.radiusLg),
                            bottomLeft: Radius.circular(isUser ? AppDimensions.radiusLg : 0),
                            bottomRight: Radius.circular(isUser ? 0 : AppDimensions.radiusLg),
                          ),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        child: Column(
                          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.message,
                              style: AppTextStyles.bodyMd.copyWith(
                                color: isUser ? AppColors.onPrimary : AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                              style: AppTextStyles.labelSm.copyWith(
                                color: isUser ? AppColors.onPrimary.withValues(alpha: 0.7) : AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: AppDimensions.spaceMd,
              right: AppDimensions.spaceMd,
              top: AppDimensions.spaceSm,
              bottom: AppDimensions.spaceSm + MediaQuery.of(context).padding.bottom,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.surfaceContainerHigh,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spaceLg,
                        vertical: AppDimensions.spaceMd,
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceSm),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary,
                  child: _isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onPrimary,
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.send, color: AppColors.onPrimary, size: 20),
                          onPressed: _sendMessage,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
