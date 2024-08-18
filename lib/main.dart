import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/chat_bloc.dart';
import 'package:flutter_gemini_ai/chat_screen.dart';
import 'package:flutter_gemini_ai/constant.dart';
import 'package:flutter_gemini_ai/cubit/image_picker_cubit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GenerativeModel(
      // model: 'gemini-1.5-flash-latest',
      model: 'gemini-pro',
      apiKey: APIKEY,
    );
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
