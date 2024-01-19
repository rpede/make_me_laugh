import 'package:flutter/material.dart';

import 'data/settings.dart';
import 'data_provider.dart';
import 'pages/joke_page.dart';

void main() async {
  await Settings.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return createDataProviders(
      child: MaterialApp(
        title: 'Make Me Laugh',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const JokePage(),
      ),
    );
  }
}
