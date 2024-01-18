import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/joke_dto.dart';
import '../data/joke_service.dart';
import '../widgets/avatar.dart';
import '../widgets/joke_presenter.dart';
import 'settings_page.dart';

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  late JokeService service;

  JokeDto? joke;

  @override
  void initState() {
    super.initState();
    service = context.read<JokeService>();
    _loadJoke();
  }

  _loadJoke() async {
    setState(() {
      joke = null;
    });
    final newJoke = await service.tellAJoke();
    setState(() {
      joke = newJoke;
    });
  }

  _goToSettingsPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jokes"), centerTitle: true, actions: [
        IconButton(
            onPressed: _goToSettingsPage, icon: const Icon(Icons.settings)),
      ]),
      body: Center(
        child: joke != null
            ? Stack(
                children: [
                  ListView(children: [
                    Avatar(seed: "${joke?.id}"),
                    const SizedBox(height: 8),
                    JokePresenter(joke!),
                    const SizedBox(height: 48)
                  ]),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: _loadJoke,
                      child: const Text(
                        "Make me laugh",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  )
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
