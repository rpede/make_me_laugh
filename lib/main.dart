import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

import 'data/settings.dart';
import 'data_provider.dart';
import 'pages/joke_page.dart';

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
    return createDataProviders(
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: MaterialApp(
          title: 'Make Me Laugh',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const JokePage(),
        ),
      ),
    );
  }
}
