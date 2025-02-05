import 'package:flutter/material.dart';
import 'package:flutter_gemini_ai/features/chat/presentation/chat_screen.dart';

import '../features/home/presentation/page/home_screen.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static const String initialRoute = '/';
  static const String chat = '/chat';
}