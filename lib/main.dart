import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/bloc/chat_bloc.dart';
import 'package:flutter_gemini_ai/chat_screen.dart';
import 'package:flutter_gemini_ai/utils.dart';
import 'package:flutter_gemini_ai/bloc/image_picker_cubit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    // model: 'gemini-pro',
    apiKey: APIKEY,
  );

  runApp(MyApp(model: model));
}

class MyApp extends StatelessWidget {
  final GenerativeModel model;

  const MyApp({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChatBloc(model),
        ),
        BlocProvider(
          create: (_) => ImagePickerCubit(ImagePicker()),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Gemin-AI Chat',
        debugShowCheckedModeBanner: false,
        home: ChatScreen(),
      ),
    );
  }
}
