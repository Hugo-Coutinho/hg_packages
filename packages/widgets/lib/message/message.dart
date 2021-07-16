import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Message extends StatefulWidget {

  final String imageUrl;
  final String title;
  final String date;
  final VoidCallback copyMessageCallback;
  final VoidCallback onTap;

  Message(this.imageUrl, this.title, this.date, { this.copyMessageCallback, this.onTap });

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> with TickerProviderStateMixin {

  // Animations
  Animation colorAnimation;
  AnimationController colorAnimationController;
  ImageProvider _messageImage;
  var _imageStreamListener;
  final _imageConfiguration = ImageConfiguration();

  initState() {
    super.initState();
    colorAnimationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    colorAnimation =
        Tween(begin: 1.0, end: .5).animate(colorAnimationController);
    _messageImage = _settingImageListener();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (context, _) {
        return _buildItem(context);
      },
    );
  }

  @override
  dispose() {
    _messageImage.resolve(_imageConfiguration).removeListener(_imageStreamListener);
    colorAnimationController.dispose();
    super.dispose();
  }

  _buildItem(context) {
    return Container(
      height: 150,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Card(
            color: Colors.black54,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black54.withOpacity(colorAnimation.value),
                          BlendMode.hardLight),
                      fit: BoxFit.cover,
                      image: _messageImage),
                      // image: image),
                ),
                child: _columnWithContent(),
              ),
            )),
      ),
    );
  }

  _columnWithContent() {
    return Column(
      children: <Widget>[
        _headerItemBuild(),
        _textItemBuild(),
        _dateItemBuild(),
      ],
    );
  }

  _headerItemBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.copy,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  widget.copyMessageCallback();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _dateItemBuild() {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Text(widget.date,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      alignment: Alignment.centerLeft,
    );
  }

  _textItemBuild() {
    return Flexible(
      child: new Text(
        widget.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
    );
  }

  ImageProvider _settingImageListener() {
    _imageStreamListener =
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
          colorAnimationController.forward();
        });
    var image = Image.network(widget.imageUrl).image;
    image.resolve(_imageConfiguration).addListener(_imageStreamListener);
    return image;
  }
}
