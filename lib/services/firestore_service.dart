import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/models/skill.dart';

class FirestoreService {
  static final CollectionReference<Character> ref = FirebaseFirestore.instance
      .collection("characters")
      .withConverter(
        fromFirestore: Character.fromFireStore,
        toFirestore: (Character model, _) => model.toFireStore(),
      );

  static Future<void> addCharacter(Character character) {
    return ref.doc(character.id).set(character);
  }

  static Future<void> deleteCharacter(Character character) {
    return ref.doc(character.id).delete();
  }

  static Future<QuerySnapshot<Character>> getCharactersOnce() {
    return ref.get();
  }

  static Future<void> updateCharacter(Character character) async {
    return ref.doc(character.id).update(<Object, Object?>{
      "stats": character.statsAsMap,
      "points": character.points,
      "skills": character.skills.map((Skill s) => s.id).toList(),
      "isFav": character.isFav,
    });
  }
}
