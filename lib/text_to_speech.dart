import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextToSpeech extends StatelessWidget {
  const TextToSpeech({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final TextEditingController _controller = TextEditingController();
  final flutterTts = FlutterTts();
  bool isPLaying = false;

  void initializeTextToSpeech() {
    flutterTts.setStartHandler(() {
      setState(() {
        isPLaying = true;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPLaying = false;
      });
    });
    flutterTts.setErrorHandler((message) {
      setState(() {
        isPLaying = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeTextToSpeech();
  }

  void speak() async {
    if (_controller.text.isNotEmpty) {
      isPLaying = true;
      await flutterTts.speak(_controller.text);
    } else {
      Fluttertoast.showToast(
          msg: 'Please enter a valid data',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  void stop() async {
    setState(() {
      flutterTts.stop();
      isPLaying = false;
    });
  }

  @override
  void dispose() {
    isPLaying = false;
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speech'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              reverse: true,
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                  ),
                  maxLines: 6,
                  controller: _controller,
                  style: TextStyle(color: Colors.black, fontSize: 15),

                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                isPLaying ? stop() : speak();
              },
              child: Icon(isPLaying ? Icons.pause : Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}