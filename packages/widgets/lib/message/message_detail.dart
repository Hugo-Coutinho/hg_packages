import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageDetail extends StatelessWidget {

  // "https://cdn.faithgateway.com/uploads/2018/10/praying-400.png"
  // "Blur Background Image in Flutter Blur Background Image in FlutterBlur Background\n Image in FlutterBlur Background Image in FlutterBlur Background Image\n in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in Flutter Blur Background Image in Flutter Blur Background Image in FlutterBlur Background\n Image in FlutterBlur Background Image in FlutterBlur Background Image\n in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in Flutter\n Blur Background Image in Flutter Blur Background Image in FlutterBlur Background\n Image in FlutterBlur Background Image in FlutterBlur Background Image\n in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in Flutter Blur Background Image in Flutter Blur Background Image in FlutterBlur Background\n Image in FlutterBlur Background Image in FlutterBlur Background Image\n in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in Flutter Blur Background Image in FlutterBlur Background\n Image in FlutterBlur Background Image in FlutterBlur Background Image\n in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in Flutter Blur Background Image in Flutter Blur Background Image in FlutterBlur Background\n Image in FlutterBlur Background Image in FlutterBlur Background Image\n in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in Flutter\n Blur Background Image in Flutter Blur Background Image in FlutterBlur Background\n Image in FlutterBlur Background Image in FlutterBlur Background Image\n in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in Flutter Blur Background Image in Flutter Blur Background Image in FlutterBlur Background\n Image in FlutterBlur Background Image in FlutterBlur Background Image\n in FlutterBlur Background Image in FlutterBlur Background Image in FlutterBlur Background Image in Flutter"
  final String _imageUrl;
  final String _message;

  MessageDetail(this._imageUrl, this._message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  AppBar(
        backgroundColor: Colors.grey.withOpacity(0),
        elevation: 0,
      ),
      body: CachedNetworkImage(
        imageUrl: _imageUrl,
        imageBuilder: (context, imageProvider) =>
            Container(
              decoration: _buildBackgroundImage(imageProvider),
              child: _buildBlurWidget(SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        _buildShareButton(context),
                        _buildBlurWidget(_buildText()),
                      ],
                    ),
                  ),
                ),
              ),
              ),
            ),
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
      ),
    );
  }

  BoxDecoration _buildBackgroundImage(ImageProvider imageProvider) => BoxDecoration(
    image: DecorationImage(
      colorFilter: ColorFilter.mode(
          Colors.black54.withOpacity(.3), BlendMode.hardLight),
      image: imageProvider,
      // image: Image.network('https://cdn.faithgateway.com/uploads/2018/10/praying-400.png').image,
      fit: BoxFit.cover,
    ),
  );

  Widget _buildText() => Padding(
    padding: const EdgeInsets.all(11.0),
    child: Text(
          _message,
          textAlign: TextAlign.center,
          maxLines: 24,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
  );

  Widget _buildShareButton(BuildContext context) => IconButton(
        icon: Icon(
          Icons.copy,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {
          print('share click');
        },
      );

  Widget _buildBlurWidget(Widget child) => ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.withOpacity(0),
        child: child,
      ),
    ),
  );
}
