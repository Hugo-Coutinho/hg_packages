import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:widgets/constant/constant.dart';
import 'package:widgets/widgets.dart';

class MessageDetail extends StatelessWidget {
  final String imageUrl;
  final String message;
  final Color backgroundColor;
  final Function copyPressed;

  MessageDetail({ this.imageUrl, this.message, this.backgroundColor, this.copyPressed });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor,
        appBar:  AppBar(
          backgroundColor: Colors.grey.withOpacity(0),
          elevation: 0,
        ),
        body: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) =>
            _build(context, imageProvider),
          placeholder: (context, url) => Center(child: Loading()),
          errorWidget: (context, url, error) => _build(context, Image.asset(defaultBackgroundImageAsset).image)),
      ),
    );
  }

  BoxDecoration _buildBackgroundImage(ImageProvider imageProvider) => BoxDecoration(
    image: DecorationImage(
      colorFilter: ColorFilter.mode(
          Colors.black54.withOpacity(.3), BlendMode.hardLight),
      image: imageProvider,
      fit: BoxFit.cover,
    ),
  );

  Widget _build(BuildContext context, ImageProvider currentImage) =>
      Container(
        decoration: _buildBackgroundImage(currentImage),
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
      );

  Widget _buildText() => Padding(
    padding: const EdgeInsets.all(11.0),
    child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
  );

  Widget _buildShareButton(BuildContext context) => IconButton(
        icon: Icon(
          Icons.copy,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {
          copyPressed(context);
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
