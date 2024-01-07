import 'package:flutter/material.dart';
import 'package:make_me_laugh/data/joke.dart';
import 'package:make_me_laugh/widgets/joke_text.dart';

class JokePresenter extends StatelessWidget {
  final Joke joke;
  const JokePresenter(this.joke, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: switch (joke.type) {
          "single" => JokeText(joke.joke!),
          "twopart" => Column(children: [
              JokeText(joke.setup!),
              const SizedBox(height: 24),
              JokeText(joke.delivery!)
            ]),
          _ => const Text("Unknown joke type"),
        });
  }
}
