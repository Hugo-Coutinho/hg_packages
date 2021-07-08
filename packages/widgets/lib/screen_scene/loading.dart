import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgets/constant/constant.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      loadingAsset,
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );
  }
}
