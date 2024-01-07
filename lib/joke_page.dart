import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:make_me_laugh/data/data_source.dart';
import 'package:make_me_laugh/data/joke.dart';
import 'package:make_me_laugh/data/settings.dart';
import 'package:make_me_laugh/settings_page.dart';
import 'package:make_me_laugh/widgets/joke_presenter.dart';
import 'package:make_me_laugh/widgets/joke_tts.dart';
import 'package:provider/provider.dart';

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  Joke? joke;
  late Settings settings;

  @override
  void initState() {
    settings = context.read<Settings>();
    _loadJoke();
    super.initState();
  }

  _loadJoke() async {
    setState(() {
      joke = null;
    });
    final newJoke = await context.read<DataSource>().getJoke(settings);
    setState(() {
      joke = newJoke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text("Jokes"), centerTitle: true, actions: [
          IconButton(
              onPressed: _goToSettingsPage,
              icon: const Icon(Icons.settings)),
        ]),
        body: Center(
          child: joke != null
              ? Stack(
                  children: [
                    ListView(children: [
                      if (settings.enableTextToSpeech) JokeTts(joke!),
                      SvgPicture.network(
                        "https://api.dicebear.com/7.x/adventurer/svg?seed=${joke?.id}",
                        height: 300,
                        width: 300,
                      ),
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
        ));
  }

  _goToSettingsPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsPage()));
  }
}
