import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDisplay extends StatelessWidget {
  const LoadingDisplay({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: SpinKitThreeBounce(
        color: color ?? Colors.amber,
        size: 20.0,
      ),
    );
  }
}
