import 'package:flutter_gemini_ai/features/chat/domain/entities/chat_entity.dart';

final class ChatModel extends ChatEntity {
  const ChatModel({
    required super.text,
    required super.isUser,
    super.isLoading,
    super.imagePaths,
  });
}
