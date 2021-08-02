import 'package:flutter/material.dart';

class ElementDetailChip extends StatelessWidget {
  const ElementDetailChip({
    Key key,
    @required this.color,
    @required this.icon,
    @required this.title,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color,
      labelPadding: EdgeInsets.only(right: 6),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      avatar: Icon(
        icon,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}
