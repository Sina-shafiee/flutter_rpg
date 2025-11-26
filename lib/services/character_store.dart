import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/services/firestore_service.dart';

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = <Character>[];

  List<Character> get characters => _characters;

  void addCharacter(Character character) async {
    await FirestoreService.addCharacter(character);
    _characters.add(character);
    notifyListeners();
  }

  void fetchCharactersOnce() async {
    if (_characters.isEmpty) {
      final QuerySnapshot<Character> snapshot =
          await FirestoreService.getCharactersOnce();

      for (QueryDocumentSnapshot<Character> doc in snapshot.docs) {
        _characters.add(doc.data());
      }

      notifyListeners();
    }
  }

  Future<void> removeCharacter(Character character) async {
    await FirestoreService.deleteCharacter(character);
    _characters.remove(character);
    notifyListeners();
  }

  Future<void> saveCharacter(Character character) async {
    await FirestoreService.updateCharacter(character);
  }
}
