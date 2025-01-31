import 'dart:io';

import 'package:flutter_gemini_ai/features/chat/data/data_sources/chat_source.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiSource implements ChatSource {
  final ChatSession _chatSession;
  final GenerativeModel _model;

  GeminiSource({
    required GenerativeModel model,
  })  : _model = model,
        _chatSession = model.startChat();

  @override
  Future<String> sendMessage(String message) async {
    final response = await _chatSession.sendMessage(Content.text(message));

    if (response.text != null) {
      return response.text!;
    } else {
      throw 'No Response from API';
    }
  }

  @override
  Future<String> sendMessageWithImage(
    String message,
    List<String> imagePaths,
  ) async {
    final content = [
      Content.multi([
        TextPart(message),
        ...imagePaths.map((image) {
          final imageAsBytes = File(image).readAsBytesSync();
          return DataPart('image/jpeg', imageAsBytes);
        }),
      ])
    ];

    final response = await _model.generateContent(content);

    if (response.text != null) {
      return response.text!;
    } else {
      throw 'No Response from API';
    }
  }
}
