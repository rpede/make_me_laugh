import 'data_source.dart';
import 'joke_dto.dart';
import 'settings.dart';
import 'text_to_speech.dart';

class JokeService {
  final Settings settings;
  final DataSource dataSource;
  final TextToSpeech textToSpeech;

  JokeService(this.settings, this.dataSource, this.textToSpeech);

  Future<JokeDto> tellAJoke() async {
    final joke = await dataSource.getJoke(settings);
    if (settings.enableTextToSpeech) {
      await textToSpeech.speak(stringify(joke));
    }
    return joke;
  }

  String stringify(JokeDto joke) {
    if (joke.type == 'single') {
      return joke.joke!;
    } else {
      return "${joke.setup}\n\n${joke.delivery}";
    }
  }
}
