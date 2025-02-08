import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';
import 'package:aspectumai/features/chat/domain/usecases/send_chat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late ChatRepository chatRepository;
  late SendChatUsecase sendChatUsecase;

  setUp(() {
    chatRepository = MockChatRepository();
    sendChatUsecase = SendChatUsecase(chatRepository);
  });

  group('SendChatUsecase', () {
    test('call success', () async {
      when(() => chatRepository.sendMessage('hello')).thenAnswer(
        (_) async => DataSuccess('hello world'),
      );

      final result = await sendChatUsecase.call('hello');
      expect(result, isA<DataSuccess>());
      expect(result.data, 'hello world');

      verify(() => chatRepository.sendMessage('hello')).called(1);
    });

    test('call failure', () async {
      when(() => chatRepository.sendMessage('hello')).thenAnswer(
        (_) async => DataError('No Response from API'),
      );

      final result = await sendChatUsecase.call('hello');

      expect(result, isA<DataError>());
      expect(result.error, 'No Response from API');

      verify(() => chatRepository.sendMessage('hello')).called(1);
    });
  });
}
