import 'package:flutter/material.dart';
import 'package:helm_demo/screens/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 0),
        ),
        useMaterial3: true,
      ),
      home: WelcomeScreen(
        scHeight: MediaQuery.of(context).size.height,
        scWidth: MediaQuery.of(context).size.width,
      ),
    );
  }
}
