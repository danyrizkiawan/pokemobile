import 'package:flutter/material.dart';

class LoadingDisplay extends StatelessWidget {
  const LoadingDisplay({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? Colors.amber,
      ),
    );
  }
}
