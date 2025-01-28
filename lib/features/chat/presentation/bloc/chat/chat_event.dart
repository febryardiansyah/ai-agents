part of 'chat_bloc.dart';

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
