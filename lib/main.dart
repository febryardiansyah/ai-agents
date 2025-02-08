import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aspectumai/core/app_route.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/dependency_injection.dart';
import 'package:aspectumai/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:aspectumai/features/chat/presentation/bloc/image_picker/image_picker_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRoute = AppRouter();

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
      child: MaterialApp.router(
        title: 'Aspectum AI',
        debugShowCheckedModeBanner: false,
        routerConfig: appRoute.config(),
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
      ),
    );
  }
}
