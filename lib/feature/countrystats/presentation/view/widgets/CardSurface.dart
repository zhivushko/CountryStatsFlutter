import 'package:flutter/material.dart';

class CardSurface extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const CardSurface({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        elevation: 1.0,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ),
      ),
    );
  }
}