import 'package:flutter/material.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/theme.dart';

class Heart extends StatefulWidget {
  final Character character;

  const Heart({super.key, required this.character});

  @override
  HeartState createState() => HeartState();
}

class HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: widget.character.isFav
                ? AppColors.primaryAccent
                : Colors.grey[800],
            size: _sizeAnimation.value,
          ),
          onPressed: () {
            _controller.reset();
            _controller.forward();
            widget.character.toggleIsFav();
          },
        );
      },
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _sizeAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 25.0, end: 40.0),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 40.0, end: 25.0),
        weight: 50,
      ),
    ]).animate(_controller);

    super.initState();
  }
}
