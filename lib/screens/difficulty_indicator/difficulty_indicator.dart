import 'package:flutter/material.dart';

class DifficultyIndicator extends StatelessWidget {
  final String difficulty;

  const DifficultyIndicator({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    Color indicatorColor;
    String difficultyText;
    double widthFactor;

    switch (difficulty) {
      case 'Начинающий':
        indicatorColor = Colors.green;
        difficultyText = 'Начинающий';
        widthFactor = 0.3;
        break;
      case 'Средний':
        indicatorColor = Colors.yellow;
        difficultyText = 'Средний';
        widthFactor = 0.5;
        break;
      case 'Продвинутый':
        indicatorColor = Colors.red;
        difficultyText = 'Продвинутый';
        widthFactor = 0.7;
        break;
      default:
        indicatorColor = Colors.transparent;
        difficultyText = '';
        widthFactor = 0.0;
    }

    return Row(
      children: [
        Container(
          width: 40,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: widthFactor,
            child: Container(
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          difficultyText,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
