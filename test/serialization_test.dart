import 'package:flutter_test/flutter_test.dart';
import 'package:make_me_laugh/data/joke_dto.dart';

const Map<String, dynamic> singlePartJoke = {
  "error": false,
  "category": "Programming",
  "type": "single",
  "joke":
      "Being a self-taught developer is almost the same as being a cut neck chicken because you have no sense of direction in the beginning.",
  "flags": {
    "nsfw": false,
    "religious": false,
    "political": false,
    "racist": false,
    "sexist": false,
    "explicit": false
  },
  "id": 184,
  "safe": false,
  "lang": "en"
};

const Map<String, dynamic> twoPartJoke = {
  "error": false,
  "category": "Programming",
  "type": "twopart",
  "setup": "why do python programmers wear glasses?",
  "delivery": "Because they can't C.",
  "flags": {
    "nsfw": false,
    "religious": false,
    "political": false,
    "racist": false,
    "sexist": false,
    "explicit": false
  },
  "safe": true,
  "id": 294,
  "lang": "en"
};

void main() {
  test("Deserialize single part joke", () {
    final joke = JokeDto.fromJson(singlePartJoke);
    expect(joke.type, "single");
    expect(joke.joke,
        "Being a self-taught developer is almost the same as being a cut neck chicken because you have no sense of direction in the beginning.");
  });

  test("Deserialize two part joke", () {
    final joke = JokeDto.fromJson(twoPartJoke);
    expect(joke.type, "twopart");
    expect(joke.setup, "why do python programmers wear glasses?");
    expect(joke.delivery, "Because they can't C.");
  });
}
