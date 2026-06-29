import 'package:flutter/material.dart';

class AssetTestPage extends StatelessWidget {
  const AssetTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Test'),
      ),
      body: Center(
        child: Image.asset(
          'assets/redcandy.png',
          width: 200,
          height: 200,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            debugPrint('Asset Error: $error');

            return const Text(
              'IMAGE NOT FOUND',
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}