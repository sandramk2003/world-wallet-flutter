import 'package:flutter/material.dart';
import 'package:flutterproject1/presentation/chatbot.dart';
import 'package:flutterproject1/presentation/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: 
      ChatBotScreen()
      );
  }
}
