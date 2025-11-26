import 'package:flutter/material.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/models/skill.dart';
import 'package:rpg/shared/styled_text.dart';
import 'package:rpg/theme.dart';

class SkillList extends StatefulWidget {
  final Character character;

  const SkillList(this.character, {super.key});

  @override
  SkillListState createState() => SkillListState();
}

class SkillListState extends State<SkillList> {
  late List<Skill> availableSkills;
  late Skill selectedSkill;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.secondaryColor.withValues(alpha: 0.5),
        child: Column(
          children: <Widget>[
            const StyledHeading("Choose an active skill"),
            const StyledText("Skills are unique to your vocation."),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: availableSkills.map((Skill skill) {
                return Container(
                  padding: const EdgeInsets.all(2),

                  decoration: BoxDecoration(
                    color: selectedSkill != skill
                        ? Colors.transparent
                        : Colors.amber,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  margin: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSkill = skill;
                        widget.character.updateSkill(skill);
                      });
                    },
                    child: Image.asset(
                      'assets/img/skills/${skill.image}',
                      width: 70,
                      colorBlendMode: BlendMode.color,
                      color: selectedSkill != skill
                          ? Colors.black.withValues(alpha: 0.8)
                          : Colors.transparent,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            StyledText(selectedSkill.name),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    availableSkills = allSkills
        .where((Skill skill) => skill.vocation == widget.character.vocation)
        .toList();
    if (widget.character.skills.isEmpty) {
      selectedSkill = availableSkills.first;
    } else if (widget.character.skills.isNotEmpty) {
      selectedSkill = widget.character.skills.first;
    }
  }
}
