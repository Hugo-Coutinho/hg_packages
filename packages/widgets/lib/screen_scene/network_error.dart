import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgets/constant/constant.dart';

class NetworkError extends StatelessWidget {

  final String _textTitle;
  final VoidCallback _completion;

  NetworkError(this._textTitle, this._completion);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _connectionFailureAnimation(),
        SizedBox(height: 10),
        _retryConnectionButton()
      ],
    );
  }

  Widget _connectionFailureAnimation() {
    return Lottie.asset(
      networkErrorAsset,
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );
  }

  Widget _retryConnectionButton() {
    return SizedBox(
      width: 220.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.teal),
        onPressed: () {
          _completion();
        },
        child: Text(
          _textTitle,
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }
}