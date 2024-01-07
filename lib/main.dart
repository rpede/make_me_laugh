import 'package:flutter/material.dart';
import 'package:make_me_laugh/data/data_source.dart';
import 'package:make_me_laugh/data/settings.dart';
import 'package:make_me_laugh/joke_page.dart';
import 'package:provider/provider.dart';

void main() {
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
