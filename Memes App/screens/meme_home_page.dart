import 'package:flutter/material.dart';
import 'package:meme_app/models/meme_model.dart';
import 'package:meme_app/widgets/meme_card.dart';
import 'package:meme_app/services/meme_sevices.dart';

class MemeHomePage extends StatefulWidget {
  const MemeHomePage({super.key});

  @override
  State<MemeHomePage> createState() => _MemeHomePageState();
}

class _MemeHomePageState extends State<MemeHomePage> {
  List<Meme> memes=[];
  bool isLoading=true;
  Color backgroundColor=Colors.deepPurple;
  @override
  void initState(){
    super.initState();
    fetchMemes();
  }

Future<void> fetchMemes() async{
  final fetchMemes=await MemeSevices.fetchMemes(context);
  setState(() {
    memes=fetchMemes ?? [];
    isLoading=false;
  });
}
  void updateBackgroundColor(Color color){
    setState(() {
      backgroundColor=color;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Meme App"),
  centerTitle: true,
  backgroundColor: backgroundColor.withValues(alpha: 0.8),
),
body: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
       backgroundColor.withValues(alpha: 0.8),
       backgroundColor.withValues(alpha: 0.4),
        ]
      )
  ),
  child: isLoading ?Center(child: CircularProgressIndicator()):memes.isEmpty
  ?Center(child: Text('No meme available'))
  :ListView.builder(
    itemCount: memes.length,
    itemBuilder: (context,index){
      final meme=memes[index];
      return MemeCard(title:meme.title, 
      imageUrl: meme.url,
       ups: meme.ups, 
       postLink: meme.postLink,
        onColorExtracted: updateBackgroundColor,
        );
    }
    )
  ,
),
    );
  }
}