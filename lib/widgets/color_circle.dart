import 'package:flutter/material.dart';

class ColorCircle extends StatefulWidget {
  final color;
  const ColorCircle({required this.color,super.key});
  @override
  State<ColorCircle> createState() => _ColorCircleState();
}

class _ColorCircleState extends State<ColorCircle> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          // Toggle selection
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: Theme.of(context).primaryColor, width: 3)
                : null,
          ),
          child: CircleAvatar(
            backgroundColor: widget.color,
            radius: 12,
          ),
        ),
      ),
    );
  }
}
