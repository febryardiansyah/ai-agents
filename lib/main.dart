import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/core/app_route.dart';
import 'package:flutter_gemini_ai/core/resources/colors.dart';
import 'package:flutter_gemini_ai/dependency_injection.dart';
import 'package:flutter_gemini_ai/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter_gemini_ai/features/chat/presentation/bloc/image_picker/image_picker_cubit.dart';

import 'features/home/presentation/page/home_screen.dart';

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
          create: (_) => ChatBloc(sl(), sl()),
        ),
        BlocProvider(
          create: (_) => ImagePickerCubit(sl()),
        ),
      ],
      child: MaterialApp(
        title: 'Aspectum AI',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => AppRoute.generateRoute(settings),
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.primary,
          appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0,
          ),
          colorScheme: const ColorScheme.light(
            background: Colors.white,
            onBackground: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
