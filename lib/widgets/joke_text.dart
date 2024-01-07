import 'package:flutter/material.dart';

class JokeText extends StatelessWidget {
  final String text;
  const JokeText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.purple,
      elevation: 20,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text, style: const TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}
