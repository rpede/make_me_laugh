import 'dart:convert';

import 'package:http/http.dart' as http;

import 'joke_dto.dart';
import 'settings.dart';

class DataSource {
  Future<JokeDto> getJoke(Settings settings) async {
    final path = settings.categories.isEmpty
        ? "Any"
        : settings.categories.map((e) => e.name).join(",");
    final query =
        "blacklistFlags=${settings.blacklistFlags.map((e) => e.name).join(',')}";
    final url = "https://v2.jokeapi.dev/joke/$path?$query";
    final response = await http.get(Uri.parse(url));
    final map = json.decode(response.body);
    return JokeDto.fromJson(map);
  }
}
