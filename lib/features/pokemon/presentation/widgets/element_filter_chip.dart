
import 'package:flutter/material.dart';

class ElementFilterChip extends StatelessWidget {
  const ElementFilterChip({
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(
        right: 6,
        top: 6,
        bottom: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
