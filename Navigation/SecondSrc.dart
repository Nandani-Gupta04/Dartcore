import 'package:flutter/material.dart';

class SecondSrc extends StatelessWidget {
  const SecondSrc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Go to Home Screen"),
        ),
      ),
    );
  }
}