import 'dart:io';

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

class StartImageChatEvent extends ChatBlocEvent {
  final String message;
  final List<String> imagePaths;

  StartImageChatEvent({required this.imagePaths, required this.message});

  @override
  List<Object?> get props => [imagePaths, message];
}

class ChatBloc extends Bloc<ChatBlocEvent, List<ChatModel>> {
  ChatBloc(GenerativeModel model)
      : _model = model,
        _chatSession = model.startChat(),
        super([]) {
    on<StartChatEvent>(_startChat);
    on<StartImageChatEvent>(_startImageChat);
  }

  final ChatSession _chatSession;
  final GenerativeModel _model;

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

      final response = await _chatSession.sendMessage(Content.text(newMessage));
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

  void _startImageChat(
    StartImageChatEvent event,
    Emitter<List<ChatModel>> emit,
  ) async {
    final content = [
      Content.multi([
        TextPart(event.message),
        ...event.imagePaths.map((image) {
          final imageAsBytes = File(image).readAsBytesSync();
          return DataPart('image/jpeg', imageAsBytes);
        }),
      ])
    ];

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

      final response = await _model.generateContent(content);
      if (response.text != null) {
        tempMessages[tempMessages.length - 1] = ChatModel(
          text: response.text!,
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
      tempMessages[tempMessages.length - 1] = ChatModel(
        text: 'Error: $e',
        isUser: false,
        isLoading: false,
      );
      emit(tempMessages);
    }
  }
}
