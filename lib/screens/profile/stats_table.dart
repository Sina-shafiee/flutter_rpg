import 'package:flutter/material.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/shared/styled_text.dart';
import 'package:rpg/theme.dart';

class StatsTable extends StatefulWidget {
  final Character character;

  const StatsTable(this.character, {super.key});

  @override
  StatsTableState createState() => StatsTableState();
}

class StatsTableState extends State<StatsTable> {
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          // available points
          Container(
            color: AppColors.secondaryColor.withValues(alpha: 0.5),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 500),
                  child: Icon(
                    Icons.star,
                    color: widget.character.points > 0
                        ? Colors.yellow
                        : Colors.grey,
                  ),
                ),
                const SizedBox(width: 20),
                const StyledText("Stat  points available: "),
                const Expanded(child: SizedBox(width: 20)),
                StyledHeading(widget.character.points.toString()),
              ],
            ),
          ),

          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: IntrinsicColumnWidth(),
              3: IntrinsicColumnWidth(),
            },
            children: widget.character.statsAsFormattedList.map((
              Map<String, String> stat,
            ) {
              return TableRow(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withValues(alpha: 0.3),
                ),
                children: <Widget>[
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: StyledHeading(stat['title']!),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: StyledHeading(stat['value']!),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      onPressed: widget.character.points > 0
                          ? () {
                              setState(() {
                                widget.character.increaseStat(stat['title']!);
                                turns += 1;
                              });
                            }
                          : null,
                      icon: Icon(
                        Icons.arrow_upward,
                        color: widget.character.points > 0
                            ? AppColors.textColor
                            : AppColors.textColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      onPressed:
                          widget.character.statsAsMap[stat['title']!]! > 5
                          ? () {
                              setState(() {
                                widget.character.decreaseStat(stat['title']!);
                                turns -= 1.0;
                              });
                            }
                          : null,
                      icon: Icon(
                        Icons.arrow_downward,
                        color: widget.character.statsAsMap[stat['title']!]! > 5
                            ? AppColors.textColor
                            : AppColors.textColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
