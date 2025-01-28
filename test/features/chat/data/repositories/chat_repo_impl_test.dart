import 'package:flutter_gemini_ai/core/resources/data_state.dart';
import 'package:flutter_gemini_ai/features/chat/data/data_sources/chat_source.dart';
import 'package:flutter_gemini_ai/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:flutter_gemini_ai/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatSource extends Mock implements ChatSource {}

void main() {
  late ChatSource chatSource;
  late ChatRepository chatRepository;

  setUp(() {
    chatSource = MockChatSource();
    chatRepository = ChatRepositoryImpl(chatSource);
  });

  group('ChatRepository', () {
    test('send chat success', () async {
      when(() => chatSource.sendMessage('hello'))
          .thenAnswer((_) async => 'hello world');

      final result = await chatRepository.sendMessage('hello');

      expect(result, isA<DataSuccess<String>>());
      expect(result.data, 'hello world');

      verify(() => chatSource.sendMessage('hello')).called(1);
    });

    test('send chat failure', () async {
      when(() => chatSource.sendMessage('hello'))
          .thenThrow('No Response from API');

      final result = await chatRepository.sendMessage('hello');

      expect(result, isA<DataError<String>>());
      expect(result.error, 'No Response from API');

      verify(() => chatSource.sendMessage('hello')).called(1);
    });
  });
}
