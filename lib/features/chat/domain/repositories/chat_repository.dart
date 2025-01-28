import 'package:flutter_gemini_ai/core/resources/data_state.dart';

abstract class ChatRepository {
  Future<DataState<String>> sendMessage(String message);
}