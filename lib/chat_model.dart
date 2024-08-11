import 'package:equatable/equatable.dart';

final class ChatModel extends Equatable {
  final String text;
  final bool isUser;
  final bool isLoading;

  const ChatModel({
    required this.text,
    required this.isUser,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [text, isUser, isLoading];
}
