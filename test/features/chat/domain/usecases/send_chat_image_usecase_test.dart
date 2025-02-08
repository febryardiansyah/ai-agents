import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';
import 'package:aspectumai/features/chat/domain/usecases/send_chat_with_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late ChatRepository chatRepository;
  late SendChatWithImageUsecase sendChatWithImageUsecase;

  setUp(() {
    chatRepository = MockChatRepository();
    sendChatWithImageUsecase = SendChatWithImageUsecase(chatRepository);
  });

  group('SendChatWithImageUsecase', () {
    test('send chat with image success', () async {
      when(
        () => chatRepository.sendMessageWithImage(
          'hello',
          ['image1', 'image2'],
        ),
      ).thenAnswer((_) async => DataSuccess('hello world'));

      final result = await sendChatWithImageUsecase.call(
        ChatWithImageParams(
          message: 'hello',
          imagePaths: ['image1', 'image2'],
        ),
      );
      
      expect(result, isA<DataSuccess<String>>());
      expect(result.data, 'hello world');

      verify(
        () => chatRepository.sendMessageWithImage(
          'hello',
          ['image1', 'image2'],
        ),
      ).called(1);
    });

    test('send chat with image failed', () async {
      when(
        () => chatRepository.sendMessageWithImage(
          'hello',
          ['image1', 'image2'],
        ),
      ).thenAnswer((_) async => DataError('error'));

      final result = await sendChatWithImageUsecase.call(
        ChatWithImageParams(
          message: 'hello',
          imagePaths: ['image1', 'image2'],
        ),
      );
      
      expect(result, isA<DataError<String>>());
      expect(result.error, 'error');

      verify(
        () => chatRepository.sendMessageWithImage(
          'hello',
          ['image1', 'image2'],
        ),
      ).called(1);
    });
  });
}
