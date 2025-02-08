import 'package:aspectumai/core/resources/data_state.dart';

abstract class ChatRepository {
  Future<DataState<String>> sendMessage(String message);
  Future<DataState<String>> sendMessageWithImage(
    String message,
    List<String> imagePaths,
  );
}
