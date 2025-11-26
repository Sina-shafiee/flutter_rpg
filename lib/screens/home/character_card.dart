import 'package:flutter/material.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/screens/profile/profile.dart';
import 'package:rpg/shared/styled_text.dart';
import 'package:rpg/theme.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: <Widget>[
            Hero(
              tag: character.id,
              child: Image.asset(
                'assets/img/vocations/${character.vocation.image}',
                width: 80,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StyledHeading(character.name),
                const SizedBox(height: 8),
                StyledText(character.vocation.title),
              ],
            ),
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext ctx) =>
                        ProfileScreen(character: character),
                  ),
                );
              },
              icon: Icon(Icons.arrow_forward, color: AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
