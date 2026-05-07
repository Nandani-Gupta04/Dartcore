import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {

  final bool isChecked;
  final String todoText;

  final Function(bool?)? onChanged;

  const TodoItem({super.key , required this.isChecked, required this.onChanged, required this.todoText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.deepPurple[500],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
      Checkbox(value: isChecked, onChanged: onChanged),
      Text(todoText,
      style: TextStyle(
        decoration: isChecked? TextDecoration.lineThrough:TextDecoration.none,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      ),
        ],
      ),
      ),
    );
  }
}