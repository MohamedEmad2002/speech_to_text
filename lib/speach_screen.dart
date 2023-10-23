import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  String text = 'Hold the button and start to speak';
  bool isListeining = false;
  SpeechToText speechToText = SpeechToText();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 70,
        animate: isListeining,
        glowColor: Colors.tealAccent,
        curve: Curves.easeIn,
        repeatPauseDuration: const Duration(milliseconds: 100),
        duration: const Duration(milliseconds: 2000),
        child: GestureDetector(
          onTapDown: (details) async{
            if(!isListeining){
              var avaliable = await speechToText.initialize();
              if(avaliable){
                isListeining = true;
                speechToText.listen(
                  onResult: (result) {
                    setState(() {
                      text = result.recognizedWords;
                    });
                  },
                );
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListeining = false;
            });
            speechToText.stop();
          },
          child:  CircleAvatar(
            radius: 35,
            backgroundColor: Colors.teal,
            child: Icon(isListeining? Icons.mic:Icons.mic_none, color: Colors.white),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Text to Speech",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: const EdgeInsets.only(bottom: 150),
        child: Text(text),
      ),
    );
  }
}
