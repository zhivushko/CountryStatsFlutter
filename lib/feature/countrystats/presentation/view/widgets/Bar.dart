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
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {

          final double calculatedWidth = constraints.maxWidth * 0.3;

          final double clampedWidth = calculatedWidth.clamp(50, 200);

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: clampedWidth,
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
              Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}