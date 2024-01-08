import 'package:localstorage/localstorage.dart';
import 'package:make_me_laugh/data/joke_dto.dart';

class Settings {
  static final LocalStorage _storage = LocalStorage('settings');
  bool enableTextToSpeech = false;
  List<JokeCategory> categories = [];
  List<BlacklistFlags> blacklistFlags = [];

  static Future<bool> init() async => await _storage.ready;

  void load() {
    enableTextToSpeech =
        (_storage.getItem("enableTextToSpeech") as bool?) ?? false;
    final categories = (_storage.getItem("categories") as List<dynamic>?);
    this.categories = JokeCategory.fromJson(categories ?? []);
    final blacklistFlags = _storage.getItem("blacklistFlags") as List<dynamic>?;
    this.blacklistFlags = BlacklistFlags.fromJson(blacklistFlags ?? []);
  }

  Future<void> save(Settings settings) async {
    await _storage.setItem("enableTextToSpeech", enableTextToSpeech);
    await _storage.setItem(
        "categories", JokeCategory.toJson(settings.categories));
    await _storage.setItem(
        "blacklistFlags", BlacklistFlags.toJson(settings.blacklistFlags));
  }
}
