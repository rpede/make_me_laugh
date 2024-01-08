import 'package:flutter/material.dart';
import 'package:make_me_laugh/data/data_source.dart';
import 'package:make_me_laugh/data/joke_dto.dart';
import 'package:make_me_laugh/data/settings.dart';
import 'package:make_me_laugh/extensions.dart';
import 'package:make_me_laugh/settings_page.dart';
import 'package:make_me_laugh/data/text_to_speech.dart';
import 'package:make_me_laugh/widgets/avatar.dart';
import 'package:make_me_laugh/widgets/joke_presenter.dart';
import 'package:provider/provider.dart';

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  late Settings settings;
  late DataSource dataSource;
  late TextToSpeech textToSpeech;

  JokeDto? joke;

  @override
  void initState() {
    settings = context.read<Settings>();
    dataSource = context.read<DataSource>();
    textToSpeech = context.read<TextToSpeech>();
    _loadJoke();
    super.initState();
  }

  _loadJoke() async {
    setState(() {
      joke = null;
    });
    final newJoke = await dataSource.getJoke(settings);
    if (settings.enableTextToSpeech) {
      await textToSpeech.speak(newJoke.tell());
    }
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
