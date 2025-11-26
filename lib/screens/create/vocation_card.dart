import 'package:flutter/material.dart';
import 'package:rpg/models/vocation.dart';
import 'package:rpg/shared/styled_text.dart';
import 'package:rpg/theme.dart';

class VocationCard extends StatelessWidget {
  final Vocation vocation;
  final void Function(Vocation) onTap;
  final bool isActive;

  const VocationCard({
    super.key,
    required this.vocation,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(vocation),
      child: Card(
        color: isActive ? AppColors.secondaryColor : Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: isActive
                ? Border.all(color: AppColors.textColor, width: 0.5)
                : Border.all(color: Colors.transparent, width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsetsGeometry.all(8),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/img/vocations/${vocation.image}",
                  width: 80,
                  colorBlendMode: BlendMode.color,
                  color: !isActive
                      ? Colors.black.withValues(alpha: .8)
                      : Colors.transparent,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      StyledHeading(vocation.title),
                      StyledText(vocation.description),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
