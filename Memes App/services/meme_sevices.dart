import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meme_app/models/meme_model.dart';
import 'package:http/http.dart' as http;
class MemeSevices {
  static Future<List<Meme>?> fetchMemes(BuildContext context)async{
    final url=Uri.parse('https://meme-api.com/gimme/wholesomememes/50');
try{
final respone=await http.get(url);
if(respone.statusCode==200){
  final data=json.decode(
    respone.body );
    final memes =(data['memes'] as List).map((meme) => Meme.fromJson(meme)).toList();
return memes;
}else{
throw Exception('Failed to load memes');
}
}catch(e){
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Error to load memes:')),
  );
  return null;

}
  }
}