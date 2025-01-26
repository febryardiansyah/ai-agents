import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/features/chat/screen/bloc/chat/chat_bloc.dart';
import 'package:flutter_gemini_ai/bloc/theme_cubit.dart';
import 'package:flutter_gemini_ai/core/constants/constants.dart';
import 'package:flutter_gemini_ai/features/chat/screen/chat_screen.dart';
import 'package:flutter_gemini_ai/features/chat/screen/bloc/image_picker/image_picker_cubit.dart';
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
        BlocProvider(
          create: (_) => ThemeCubit()..getTheme(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Flutter Gemin-AI Chat',
                debugShowCheckedModeBanner: false,
                themeMode: state ? ThemeMode.dark : ThemeMode.light,
                theme: ThemeData(
                  colorScheme: const ColorScheme.light(
                    background: Colors.white,
                  ),
                ),
                darkTheme: ThemeData(
                  colorScheme: ColorScheme.dark(
                    background: Colors.grey.shade900,
                  ),
                ),
                home: const ChatScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
