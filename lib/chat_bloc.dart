import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini_ai/chat_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

sealed class ChatBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartChatEvent extends ChatBlocEvent {
  final String message;

  StartChatEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatBloc extends Bloc<ChatBlocEvent, List<ChatModel>> {
  ChatBloc(GenerativeModel model)
      : _model = model,
        super([]) {
    on<StartChatEvent>(_startChat);
  }

  final GenerativeModel _model;

  Future<void> _startChat(
    StartChatEvent event,
    Emitter<List<ChatModel>> emit,
  ) async {
    final chatSession = _model.startChat();

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

      final response = await chatSession.sendMessage(Content.text(newMessage));
      if (response.text != null) {
        /// replace the loading indicator with the response
        tempMessages[tempMessages.length - 1] = ChatModel(
          text: response.text!,
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
}
