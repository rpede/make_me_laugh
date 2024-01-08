import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:make_me_laugh/data/data_source.dart';
import 'package:make_me_laugh/data/settings.dart';
import 'package:make_me_laugh/joke_page.dart';
import 'package:make_me_laugh/data/text_to_speech.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  TtsMicrosoft.init(
    subscriptionKey: dotenv.env["TTS_SUBSCRIPTION_KEY"]!,
    region: dotenv.env["TTS_REGION"]!,
    withLogs: true,
  );
  await Settings.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => DataSource()),
        Provider(create: (context) => Settings()..load()),
        Provider(
          create: (context) => TextToSpeech(),
          dispose: (_, value) => value.dispose(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const JokePage(),
      ),
    );
  }
}
