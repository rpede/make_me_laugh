class Joke {
  bool? error;
  String? category;
  String? type;
  String? setup;
  String? delivery;
  String? joke;
  Flags? flags;
  bool? safe;
  int? id;
  String? lang;

  Joke(
      {this.error,
      this.category,
      this.type,
      this.setup,
      this.delivery,
      this.joke,
      this.flags,
      this.safe,
      this.id,
      this.lang});

  Joke.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    category = json['category'];
    type = json['type'];
    setup = json['setup'];
    delivery = json['delivery'];
    joke = json['joke'];
    flags = json['flags'] != null ? new Flags.fromJson(json['flags']) : null;
    safe = json['safe'];
    id = json['id'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['category'] = this.category;
    data['type'] = this.type;
    data['setup'] = this.setup;
    data['delivery'] = this.delivery;
    data['joke'] = this.joke;
    if (this.flags != null) {
      data['flags'] = this.flags!.toJson();
    }
    data['safe'] = this.safe;
    data['id'] = this.id;
    data['lang'] = this.lang;
    return data;
  }
}

class Flags {
  bool? nsfw;
  bool? religious;
  bool? political;
  bool? racist;
  bool? sexist;
  bool? explicit;

  Flags(
      {this.nsfw,
      this.religious,
      this.political,
      this.racist,
      this.sexist,
      this.explicit});

  Flags.fromJson(Map<String, dynamic> json) {
    nsfw = json['nsfw'];
    religious = json['religious'];
    political = json['political'];
    racist = json['racist'];
    sexist = json['sexist'];
    explicit = json['explicit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nsfw'] = this.nsfw;
    data['religious'] = this.religious;
    data['political'] = this.political;
    data['racist'] = this.racist;
    data['sexist'] = this.sexist;
    data['explicit'] = this.explicit;
    return data;
  }
}

enum JokeCategory {
  Programming,
  Miscellaneous,
  Dark,
  Pun,
  Spooky,
  Christmas;

  static List<dynamic> toJson(List<JokeCategory> data) {
    return data.map((e) => e.name).toList();
  }

  static List<JokeCategory> fromJson(List<dynamic> data) {
    return data.map((e) => values.byName(e)).toList();
  }
}

enum BlacklistFlags {
  nsfw,
  religious,
  political,
  racist,
  sexist,
  explicit;

  static List<dynamic> toJson(List<BlacklistFlags> data) {
    return data.map((e) => e.name).toList();
  }

  static List<BlacklistFlags> fromJson(List<dynamic> data) {
    return data.map((e) => values.byName(e)).toList();
  }
}
