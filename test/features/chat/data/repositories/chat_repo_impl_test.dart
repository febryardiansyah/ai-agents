import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/data/data_sources/chat_source.dart';
import 'package:aspectumai/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';
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
    group('send chat only', () {
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

    group('send chat with image', () {
      test('send chat with image success', () async {
        when(
          () => chatSource.sendMessageWithImage('hello', ['image1', 'image2']),
        ).thenAnswer((_) async => 'hello world');

        final result = await chatRepository.sendMessageWithImage(
          'hello',
          ['image1', 'image2'],
        );

        expect(result, isA<DataSuccess<String>>());
        expect(result.data, 'hello world');

        verify(
          () => chatSource.sendMessageWithImage('hello', ['image1', 'image2']),
        ).called(1);
      });

      test('send chat with image failure', () async {
        when(
          () => chatSource.sendMessageWithImage('hello', ['image1', 'image2']),
        ).thenThrow('No Response from API');

        final result = await chatRepository.sendMessageWithImage(
          'hello',
          ['image1', 'image2'],
        );

        expect(result, isA<DataError<String>>());
        expect(result.error, 'No Response from API');

        verify(
          () => chatSource.sendMessageWithImage('hello', ['image1', 'image2']),
        ).called(1);
      });
    });
  });
}
