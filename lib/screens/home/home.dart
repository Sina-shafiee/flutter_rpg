import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/screens/create/create.dart';
import 'package:rpg/screens/home/character_card.dart';
import 'package:rpg/services/character_store.dart';
import 'package:rpg/shared/styled_button.dart';
import 'package:rpg/shared/styled_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StyledTitle("Your Characters")),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<CharacterStore>(
                builder:
                    (
                      BuildContext context,
                      CharacterStore value,
                      Widget? child,
                    ) => ListView.builder(
                      addRepaintBoundaries: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: ValueKey<Character>(value.characters[index]),
                          onDismissed: (DismissDirection direction) {
                            Provider.of<CharacterStore>(
                              context,
                              listen: false,
                            ).removeCharacter(
                              value.characters.reversed.toList()[index],
                            );
                          },
                          child: CharacterCard(
                            character: value.characters.reversed
                                .toList()[index],
                          ),
                        );
                      },
                      itemCount: value.characters.length,
                    ),
              ),
            ),
            StyledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext ctx) => const CreateScreen(),
                  ),
                );
              },
              child: const StyledHeading("Create Now"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Provider.of<CharacterStore>(context, listen: false).fetchCharactersOnce();

    super.initState();
  }
}
