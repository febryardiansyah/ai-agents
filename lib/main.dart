import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/dependency_injection.dart';
import 'package:flutter_gemini_ai/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter_gemini_ai/bloc/theme_cubit.dart';
import 'package:flutter_gemini_ai/features/chat/presentation/chat_screen.dart';
import 'package:flutter_gemini_ai/features/chat/presentation/bloc/image_picker/image_picker_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChatBloc(sl()),
        ),
        BlocProvider(
          create: (_) => ImagePickerCubit(sl()),
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
