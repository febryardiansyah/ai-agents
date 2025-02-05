import 'package:flutter/material.dart';
import 'package:flutter_gemini_ai/features/auth/presentation/page/login/login_screen.dart';
import 'package:flutter_gemini_ai/features/chat/presentation/chat_screen.dart';

import '../features/home/presentation/page/home_screen.dart';

Route _createRoute(Widget screen) {
  return MaterialPageRoute(builder: (_) => screen);
}

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return _createRoute(const HomeScreen());
      case chat:
        return _createRoute(const ChatScreen());
      case login:
        return _createRoute(const LoginScreen());
      default:
        return _createRoute(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static const String initialRoute = '/';
  static const String chat = '/chat';
  static const String login = '/login';
}
