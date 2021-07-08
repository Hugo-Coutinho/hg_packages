import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgets/constant/constant.dart';


class Error extends StatelessWidget {
  final String message;

  Error(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(message,
          style: TextStyle(fontFamily: 'RobotoMono'),),
        Lottie.asset(
          failureAsset,
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        )
      ],
    );
  }
}