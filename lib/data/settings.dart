import 'package:localstorage/localstorage.dart';
import 'package:make_me_laugh/data/joke.dart';

class Settings {
  final LocalStorage _storage = LocalStorage('settings');
  List<JokeCategory> categories = [];
  List<BlacklistFlags> blacklistFlags = [];

  void load() {
    final categories = (_storage.getItem("categories") as List<dynamic>?);
    this.categories = JokeCategory.fromJson(categories ?? []);
    final blacklistFlags = _storage.getItem("blacklistFlags") as List<dynamic>?;
    this.blacklistFlags = BlacklistFlags.fromJson(blacklistFlags ?? []);
  }

  Future<void> save(Settings settings) async {
    await _storage.setItem(
        "categories", JokeCategory.toJson(settings.categories));
    await _storage.setItem(
        "blacklistFlags", BlacklistFlags.toJson(settings.blacklistFlags));
  }
}
