import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpg/models/skill.dart';
import 'package:rpg/models/stats.dart';
import 'package:rpg/models/vocation.dart';

class Character with Stats {
  final String name;
  final String slogan;
  final String id;
  final Vocation vocation;
  final Set<Skill> skills = <Skill>{};

  bool _isFav = false;

  Character({
    required this.id,
    required this.name,
    required this.slogan,
    required this.vocation,
  });

  factory Character.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();

    if (data == null) {
      throw Error();
    }

    Character character = Character(
      id: snapshot.id,
      name: data['name'],
      slogan: data['slogan'],
      vocation: Vocation.values.firstWhere(
        (Vocation v) => v.toString() == data['vocation'],
      ),
    );

    for (String id in data['skills']) {
      final Skill skill = allSkills.firstWhere((Skill s) => s.id == id);
      character.updateSkill(skill);
    }

    if (data['isFav'] == true) {
      character.toggleIsFav();
    }

    character.setStats(points: data['points'], stats: data['stats']);

    return character;
  }

  bool get isFav => _isFav;

  Map<String, dynamic> toFireStore() {
    return <String, Object>{
      "name": name,
      "slogan": slogan,
      "vocation": vocation.toString(),
      "isFav": _isFav,
      "skills": skills.map((Skill skill) => skill.id).toList(),
      "stats": statsAsMap,
      "points": points,
    };
  }

  void toggleIsFav() {
    _isFav = !_isFav;
  }

  void updateSkill(Skill skill) {
    skills.clear();
    skills.add(skill);
  }
}
