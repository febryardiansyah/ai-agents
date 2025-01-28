import 'package:flutter_gemini_ai/features/chat/data/models/chat_model.dart';
import 'package:flutter_gemini_ai/features/chat/domain/entities/chat_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chat model', () {
    test('subclass of ChatEntity', () {
      expect(
          const ChatModel(
            text: '',
            isUser: true,
          ),
          isA<ChatEntity>());
    });

    test('is same model', () {
      const chat1 = ChatModel(text: '', isUser: true);
      const chat2 = ChatModel(text: '', isUser: true);

      expect(chat1, chat2);
    });
  });
}
