abstract class ChatSource {
  Future<String> sendMessage(String message);
  Future<String> sendMessageWithImage(String message, List<String> imagePaths);
}
