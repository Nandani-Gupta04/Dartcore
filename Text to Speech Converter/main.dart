import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Text to speech",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Text to Speech converter"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: TextSpeech(),
      ),
    );
  }
}
class TextSpeech extends StatelessWidget {
  final FlutterTts flutterTts=FlutterTts();
  final TextEditingController textEditingController=TextEditingController();

 Future<void> speak(String text) async{
await flutterTts.setLanguage("en-US");
await flutterTts.setPitch(0.8);
await flutterTts.speak(text);
await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
  }

  Future<void> stop()async{
flutterTts.stop();
  }
  Future<void> pause() async {
    await flutterTts.pause();
  }
 
    TextSpeech({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(padding: EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Enter text"
            ),
            controller: textEditingController,

          ),
          ElevatedButton(
            onPressed: ()=>speak(textEditingController.text), 
          child: Text('Start text to speech'),
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               ElevatedButton.icon(
                  onPressed: stop,
                  icon: const Icon(Icons.stop),
                  label: const Text("Stop"),
                ),
                ElevatedButton.icon(onPressed: pause, 
                icon: Icon(Icons.pause),
                label:Text("Pause")
                ),
            ],
          )
        ],
      ),
      ),
      
    );
  }
}