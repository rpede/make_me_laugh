import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:make_me_laugh/data/data_source.dart';
import 'package:make_me_laugh/data/joke.dart';
import 'package:make_me_laugh/data/settings.dart';
import 'package:make_me_laugh/settings_page.dart';
import 'package:make_me_laugh/widgets/joke_presenter.dart';
import 'package:provider/provider.dart';

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  Joke? joke;

  @override
  void initState() {
    _loadJoke();
    super.initState();
  }

  _loadJoke() async {
    setState(() {
      joke = null;
    });
    final settings = context.read<Settings>();
    final newJoke = await context.read<DataSource>().getJoke(settings);
    setState(() {
      joke = newJoke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {

      },
      child: Scaffold(
          appBar: AppBar(title: const Text("Jokes"), centerTitle: true, actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
                },
                icon: const Icon(Icons.settings)),
          ]),
          body: Center(
            child: joke != null
                ? Stack(
                    children: [
                      ListView(children: [
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
          )),
    );
  }
}
