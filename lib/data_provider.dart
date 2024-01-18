import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'data/data_source.dart';
import 'data/joke_service.dart';
import 'data/settings.dart';
import 'data/text_to_speech.dart';

MultiProvider createDataProviders({required Widget child}) {
  return MultiProvider(
      providers: [
      Provider(create: (context) => DataSource()),
      Provider(create: (context) => Settings()..load()),
      Provider(
        create: (context) => TextToSpeech(),
        dispose: (_, value) => value.dispose(),
      ),
      Provider(
        create: (context) => JokeService(
          context.read<Settings>(),
          context.read<DataSource>(),
          context.read<TextToSpeech>(),
        ),
      ),
    ],
    child: child,
  );
}
