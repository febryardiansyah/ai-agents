import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String text;
  final bool isUser;
  final bool isLoading;
  final List<String> imagePaths;

  const ChatEntity({
    required this.text,
    required this.isUser,
    this.isLoading = false,
    this.imagePaths = const [],
  });

  @override
  List<Object?> get props => [text, isUser, isLoading, imagePaths];
}
