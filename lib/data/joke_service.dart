import 'data_source.dart';
import 'joke_dto.dart';
import 'settings.dart';

class JokeService {
  final Settings settings;
  final DataSource dataSource;

  JokeService(this.settings, this.dataSource);

  Future<JokeDto> tellAJoke() async {
    final joke = await dataSource.getJoke(settings);
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
