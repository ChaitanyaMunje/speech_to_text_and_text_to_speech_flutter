import 'package:flutter/material.dart';
import 'package:speech_to_text_application/speech_to_text.dart';
import 'package:speech_to_text_application/text_to_speech.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: TextToSpeech(),
    );
  }
}

