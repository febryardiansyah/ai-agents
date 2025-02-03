import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_gemini_ai/core/resources/data_state.dart';
import 'package:flutter_gemini_ai/features/chat/data/models/chat_model.dart';
import 'package:flutter_gemini_ai/features/chat/domain/usecases/send_chat.dart';
import 'package:flutter_gemini_ai/features/chat/domain/usecases/send_chat_with_image.dart';
import 'package:flutter_gemini_ai/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSendChatUsecase extends Mock implements SendChatUsecase {}

class MockSendChatWithImageUsecase extends Mock
    implements SendChatWithImageUsecase {}

void main() {
  late SendChatUsecase sendChatUsecase;
  late SendChatWithImageUsecase sendChatWithImageUsecase;
  late ChatBloc chatBloc;

  setUp(() {
    sendChatUsecase = MockSendChatUsecase();
    sendChatWithImageUsecase = MockSendChatWithImageUsecase();
    chatBloc = ChatBloc(sendChatUsecase, sendChatWithImageUsecase);
  });

  tearDown(() {
    chatBloc.close();
  });

  group('ChatBloc', () {
    test('initial data must be empty list', () async {
      expect(chatBloc.state, <ChatModel>[]);
    });

    group('send chat only', () {
      blocTest(
        'send chat success with data',
        build: () {
          when(() => sendChatUsecase.call('hello')).thenAnswer(
            (_) async => DataSuccess('hello world'),
          );

          return chatBloc;
        },
        act: (bloc) => bloc.add(StartChatEvent(message: 'hello')),
        wait: const Duration(milliseconds: 300),
        verify: (_) {
          verify(() => sendChatUsecase.call('hello')).called(1);
        },
        expect: () => [
          [const ChatModel(text: 'hello', isUser: true)],
          [
            const ChatModel(text: 'hello', isUser: true),
            const ChatModel(text: '...', isUser: false, isLoading: true),
          ],
          [
            const ChatModel(text: 'hello', isUser: true, isLoading: false),
            const ChatModel(
                text: 'hello world', isUser: false, isLoading: false),
          ]
        ],
      );

      blocTest(
        'send chat failure with error',
        build: () {
          when(() => sendChatUsecase.call('hello')).thenThrow(
            'No Response from API',
          );
          return chatBloc;
        },
        act: (bloc) => bloc.add(StartChatEvent(message: 'hello')),
        wait: const Duration(milliseconds: 300),
        verify: (_) {
          verify(() => sendChatUsecase.call('hello')).called(1);
        },
        expect: () => [
          [const ChatModel(text: 'hello', isUser: true)],
          [
            const ChatModel(text: 'hello', isUser: true),
            const ChatModel(text: '...', isUser: false, isLoading: true),
          ],
          [
            const ChatModel(text: 'hello', isUser: true, isLoading: false),
            const ChatModel(
                text: 'Error: No Response from API',
                isUser: false,
                isLoading: false),
          ]
        ],
      );
    });

    group('send chat with image', () {
      blocTest(
        'send chat with image success with data',
        build: () {
          when(
            () => sendChatWithImageUsecase.call(ChatWithImageParams(
              message: 'hello',
              imagePaths: const ['imagePath'],
            )),
          ).thenAnswer(
            (_) async => DataSuccess('hello world'),
          );

          return chatBloc;
        },
        act: (bloc) => bloc.add(
          StartImageChatEvent(
            message: 'hello',
            imagePaths: const ['imagePath'],
          ),
        ),
        wait: const Duration(milliseconds: 300),
        // verify: (_) {
        //   verify(
        //     () => sendChatWithImageUsecase.call(ChatWithImageParams(
        //       message: 'hello',
        //       imagePaths: const ['imagePath'],
        //     )),
        //   ).called(1);
        // },
        // expect: () => [
        //   [
        //     const ChatModel(
        //       text: 'hello',
        //       isUser: true,
        //       imagePaths: ['imagePath'],
        //     )
        //   ],
        //   [
        //     const ChatModel(
        //       text: 'hello',
        //       isUser: true,
        //       imagePaths: ['imagePath'],
        //     ),
        //     const ChatModel(
        //       text: '...',
        //       isUser: false,
        //       isLoading: true,
        //     )
        //   ],
        //   [
        //     const ChatModel(
        //       text: 'hello',
        //       isUser: true,
        //       imagePaths: ['imagePath'],
        //     ),
        //     const ChatModel(
        //       text: 'hello world',
        //       isUser: false,
        //       isLoading: false,
        //     )
        //   ],
        // ],
      );
    });
  });
}
