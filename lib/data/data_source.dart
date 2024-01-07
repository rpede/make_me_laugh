import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:make_me_laugh/data/settings.dart';

import 'joke.dart';

class DataSource {
  Future<Joke> getJoke(Settings settings) async {
    final path = settings.categories.isEmpty ? "Any" : settings.categories.map((e) => e.name).join(",");
    final query =
        "blacklistFlags=${settings.blacklistFlags.map((e) => e.name).join(',')}";
    final url = "https://v2.jokeapi.dev/joke/$path?$query";
    print(url);
    final response = await http.get(Uri.parse(url));
    final map = json.decode(response.body);
    return Joke.fromJson(map);
  }
}
