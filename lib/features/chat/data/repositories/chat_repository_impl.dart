import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/data/data_sources/chat_source.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatSource _chatSource;

  ChatRepositoryImpl(this._chatSource);

  @override
  Future<DataState<String>> sendMessage(String message) async {
    try {
      final response = await _chatSource.sendMessage(message);

      return DataSuccess(response);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<String>> sendMessageWithImage(
      String message, List<String> imagePaths) async {
    try {
      final response = await _chatSource.sendMessageWithImage(
        message,
        imagePaths,
      );

      return DataSuccess(response);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}
