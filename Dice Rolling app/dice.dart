import 'dart:math';

import 'package:flutter/material.dart';

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() {
   return _DiceState();
  }
}
class _DiceState extends State<Dice>{
int leftDice=1;
int rightDice=1;

void rollDice(){
  setState(() {
    leftDice=Random().nextInt(6) + 1;
  rightDice=Random().nextInt(6) + 1;
    
  });
  
}

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: .center,
          children: [
            const Text(
              'Roll the dice',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/dice-$leftDice.png', height: 100, width: 100),
                  Image.asset('assets/dice-$rightDice.png', height: 100, width: 100),
                ],
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: rollDice,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                backgroundColor: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                shadowColor: Colors.black38,
                elevation: 10,
              ),
              child: Text('Roll dice',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
            ),
          ],
        );

  }
}