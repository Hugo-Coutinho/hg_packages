import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: "https://cdn.faithgateway.com/uploads/2018/10/praying-400.png",
          imageBuilder: (context, imageProvider) => Container(
            decoration: _buildBackgroundImage(imageProvider),
            child: _buildText(),
          ),
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
        ),
      ],
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

  Widget _buildText() => ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.withOpacity(0.1),
        child: Text(
          "Blur Background Image in Flutter",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
