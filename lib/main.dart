import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/chat_bloc.dart';
import 'package:flutter_gemini_ai/chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(),
      child: const MaterialApp(
        title: 'Flutter Gemin-AI Chat',
        debugShowCheckedModeBanner: false,
        home: ChatScreen(),
      ),
    );
  }
}
