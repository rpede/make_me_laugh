import 'package:make_me_laugh/data/joke_dto.dart';

extension JokeDtoExtensions on JokeDto {
  String tell() {
    if (type == 'single') {
      return joke!;
    } else {
      return "$setup\n\n$delivery";
    }
  }
}
