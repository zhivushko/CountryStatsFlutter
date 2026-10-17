import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final double value;
  final double height;
  final Color color;
  final String name;

  const Bar({
    super.key,
    required this.value,
    required this.height,
    required this.color,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded( // В Compose RowScope.Bar занимает вес (weight(1f))
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 60, // Фиксированная ширина как в Compose (fillMaxWidth(0.3f) внутри Column)
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            alignment: Alignment.center,
            child: Text(
              '${value.toInt()}%',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(name),
        ],
      ),
    );
  }
}