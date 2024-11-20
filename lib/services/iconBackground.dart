import 'package:flutter/material.dart';

class IconBackground extends StatelessWidget {
  IconBackground(
      {required this.icon,
      required this.iconColour,
      required this.iconSize,
      required this.onTap});
  IconData icon;
  double iconSize;
  Color iconColour;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: InkWell(
          splashColor: Colors.blue,
          onTap: onTap,
          child: Icon(
            icon,
            color: iconColour,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
