import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/screens/profile/heart.dart';
import 'package:rpg/screens/profile/skill_list.dart';
import 'package:rpg/screens/profile/stats_table.dart';
import 'package:rpg/services/character_store.dart';
import 'package:rpg/shared/styled_button.dart';
import 'package:rpg/shared/styled_text.dart';
import 'package:rpg/theme.dart';

class ProfileScreen extends StatelessWidget {
  final Character character;

  const ProfileScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: StyledTitle(character.name));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // basic info - image, vocation & description
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.secondaryColor.withValues(alpha: 0.3),
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: character.id,
                      child: Image.asset(
                        "assets/img/vocations/${character.vocation.image}",
                        width: 140,
                        height: 140,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          StyledHeading(character.vocation.name),
                          StyledText(character.vocation.description),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Heart(character: character),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // weapon ability and slogan
          Center(child: Icon(Icons.code, color: AppColors.primaryColor)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.secondaryColor.withValues(alpha: 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const StyledHeading("Slogan"),
                  StyledText(character.slogan),
                  const SizedBox(height: 10),

                  const StyledHeading("Weapon of choice"),
                  StyledText(character.vocation.weapon),
                  const SizedBox(height: 10),

                  const StyledHeading("Unique Ability"),
                  StyledText(character.vocation.ability),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[StatsTable(character), SkillList(character)],
            ),
          ),
          StyledButton(
            child: const StyledHeading("Save Character"),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const StyledHeading("Character was saved"),
                  showCloseIcon: true,
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColors.secondaryColor,
                ),
              );

              Provider.of<CharacterStore>(
                context,
                listen: false,
              ).saveCharacter(character);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
