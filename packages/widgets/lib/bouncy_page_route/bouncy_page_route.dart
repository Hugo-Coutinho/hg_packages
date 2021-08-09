import 'package:flutter/material.dart';

class BouncyPageRoute extends PageRouteBuilder {
  final Widget widget;
  final Color barrierColor;


  BouncyPageRoute({ this.barrierColor, this.widget }): super(
    barrierColor: barrierColor,
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
        animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
        return ScaleTransition(
          alignment: Alignment.center,
          scale: animation,
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
        return widget;
      }
  );
}