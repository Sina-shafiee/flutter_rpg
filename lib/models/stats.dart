mixin Stats {
  int _points = 10;
  int _attack = 10;
  int _defense = 10;
  int _health = 10;
  int _skill = 10;

  int get points => _points;

  List<Map<String, String>> get statsAsFormattedList => <Map<String, String>>[
    <String, String>{"title": "health", "value": _health.toString()},
    <String, String>{"title": "skill", "value": _skill.toString()},
    <String, String>{"title": "attack", "value": _attack.toString()},
    <String, String>{"title": "defense", "value": _defense.toString()},
  ];

  Map<String, int> get statsAsMap => <String, int>{
    "attack": _attack,
    "defense": _defense,
    "health": _health,
    "skill": _skill,
  };

  void decreaseStat(String stat) {
    if (stat == "health" && _health > 5) {
      _health--;
      _points++;
    } else if (stat == "attack" && _attack > 5) {
      _attack--;
      _points++;
    } else if (stat == "defense" && _defense > 5) {
      _defense--;
      _points++;
    } else if (stat == "skill" && _skill > 5) {
      _skill--;
      _points++;
    }
  }

  void increaseStat(String stat) {
    if (_points <= 0) {
      return;
    }

    switch (stat) {
      case "health":
        _health++;
        break;
      case "attack":
        _attack++;
        break;
      case "defense":
        _defense++;
        break;
      case "skill":
        _skill++;
        break;
    }
    _points--;
  }

  void setStats({required int points, required Map<String, dynamic> stats}) {
    _points = points;

    _health = stats['health'];
    _attack = stats['attack'];
    _defense = stats['defense'];
    _skill = stats['skill'];
  }
}
