import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini_ai/core/resources/data_state.dart';
import 'package:flutter_gemini_ai/features/chat/data/models/chat_model.dart';
import 'package:flutter_gemini_ai/features/chat/domain/usecases/send_chat.dart';
import 'package:flutter_gemini_ai/features/chat/domain/usecases/send_chat_with_image.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatBlocEvent, List<ChatModel>> {
  ChatBloc(this._sendChatUsecase, this._sendChatWithImageUsecase) : super([]) {
    on<StartChatEvent>(_startChat);
    on<StartImageChatEvent>(_startImageChat);
  }

  final SendChatUsecase _sendChatUsecase;
  final SendChatWithImageUsecase _sendChatWithImageUsecase;

  Future<void> _startChat(
    StartChatEvent event,
    Emitter<List<ChatModel>> emit,
  ) async {
    final newMessage = event.message;
    final tempMessages = <ChatModel>[];

    if (state.isNotEmpty) {
      /// add all previous messages
      tempMessages.addAll(state);
    }

    /// add the new message from user
    tempMessages.add(ChatModel(text: newMessage, isUser: true));
    emit([...tempMessages]);

    try {
      /// add loading indicator while waiting for response
      tempMessages.add(
        const ChatModel(text: '...', isUser: false, isLoading: true),
      );
      emit([...tempMessages]);

      final response = await _sendChatUsecase.call(newMessage);
      if (response is DataSuccess && response.data != null) {
        /// replace the loading indicator with the response
        tempMessages[tempMessages.length - 1] = ChatModel(
          text: response.data!,
          isUser: false,
          isLoading: false,
        );
        emit(tempMessages);
      } else {
        /// replace the loading indicator with a message indicating no response
        tempMessages[tempMessages.length - 1] = const ChatModel(
          text: 'No Response from API',
          isUser: false,
          isLoading: false,
        );

        emit(tempMessages);
      }
    } catch (e) {
      /// replace the loading indicator with an error message
      tempMessages[tempMessages.length - 1] = ChatModel(
        text: 'Error: $e',
        isUser: false,
        isLoading: false,
      );
      emit(tempMessages);
    }
  }

  void _startImageChat(
    StartImageChatEvent event,
    Emitter<List<ChatModel>> emit,
  ) async {
    final newMessage = event.message;
    final tempMessages = <ChatModel>[];

    if (state.isNotEmpty) tempMessages.addAll(state);

    tempMessages.add(
      ChatModel(text: newMessage, isUser: true, imagePaths: event.imagePaths),
    );
    emit([...tempMessages]);

    try {
      tempMessages.add(
        const ChatModel(text: '...', isUser: false, isLoading: true),
      );
      emit([...tempMessages]);

      final result = await _sendChatWithImageUsecase.call(ChatWithImageParams(
        message: newMessage,
        imagePaths: event.imagePaths,
      ));

      if (result is DataSuccess && result.data != null) {
        tempMessages[tempMessages.length - 1] = ChatModel(
          text: result.data!,
          isUser: false,
          isLoading: false,
        );
        emit(tempMessages);
      } else {
        tempMessages[tempMessages.length - 1] = const ChatModel(
          text: 'No Response from API',
          isUser: false,
          isLoading: false,
        );
        emit(tempMessages);
      }
    } catch (e) {
      print(e);
      tempMessages[tempMessages.length - 1] = ChatModel(
        text: 'Error: $e',
        isUser: false,
        isLoading: false,
      );
      emit(tempMessages);
    }
  }
}
