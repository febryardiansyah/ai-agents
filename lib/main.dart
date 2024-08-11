import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/chat_bloc.dart';
import 'package:flutter_gemini_ai/chat_screen.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const APIKEY = 'AIzaSyARt1kyvJc7YsLaSojscBQZectUP52AfAU';
const GEMINI_ICON = 'assets/gemini-icon.png';

void main() {
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: APIKEY,
    );

    try {
      const prompt = 'Buat cerita pendek mengenai crypto.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      print(response.text);
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
