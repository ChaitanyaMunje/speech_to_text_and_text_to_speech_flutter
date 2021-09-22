import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToText extends StatefulWidget {
  const SpeechToText({Key? key}) : super(key: key);

  @override
  _SpeechToTextState createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  late stt.SpeechToText _speechToText;
  bool isListening  = false;
  String text = 'Press the button to start speaking..';

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  void onListen() async{
    if(!isListening){
      bool avaliable = await _speechToText.initialize(
        onStatus: (val) => print('onstatus:$val'),
        onError: (val) => print('onError:$val'),
      );
      if(avaliable){
        setState(() {
          isListening = true;
        });
        _speechToText.listen(
          onResult: (val) => setState(() {
            text = val.recognizedWords;
          }),
        );
      }
    }else{
      setState(() {
        isListening = false;
        _speechToText.stop();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text'),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(isListening ? Icons.close : Icons.mic),
      onPressed: (){
        onListen();
      },),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 150),
          child: Text(text,style: TextStyle(color: Colors.black,fontSize: 15),),
        ),
      ),
    );
  }
}
