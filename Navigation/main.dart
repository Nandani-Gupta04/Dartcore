import 'package:flutter/material.dart';
import 'package:my_nav/SecondSrc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:{
        '/':(context)=>const HomeScreen(),
        '/Second':(context)=>SecondSrc(),
      }
      );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.pushNamed(context, '/second');
             },
          child: Text("Go to second screen"),
        ),
      ),
    );
  }
}
