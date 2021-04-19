import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> with TickerProviderStateMixin {

  // Animations
  Animation colorAnimation;
  AnimationController colorAnimationController;

  initState() {
    colorAnimationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    colorAnimation =
        Tween(begin: 1.0, end: .5).animate(colorAnimationController);
    super.initState();
  }

  dispose() {
    colorAnimationController.dispose();
    super.dispose();
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

  _buildItem(context) {
    String url = 'https://veja.abril.com.br/wp-content/uploads/2019/12/49175448521_774ccf3962_b.jpg';
    var image = Image.network(url).image;
    image
        .resolve(ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo image, bool synchronousCall) {
         colorAnimationController.forward();
           }));

    return Container(
      height: 150,
      child: InkWell(
        onTap: (){},
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
                      image: image),
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
        Text(
          'row testing',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  print('share click');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => {
                  print('click to favorite')
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _dateItemBuild() {
    // Parse date to normal format
    // DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    // final unformedDate = format.parse('1997-14-07');
    // Duration difference = unformedDate.difference(DateTime.now());

    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Text( '14/07/1997 14:00'
        // (int.tryParse(difference.inHours.abs().toString()) < 12)
        //     ? difference.inHours.abs().toString() + " hours ago"
        //     : difference.inDays.abs().toString() + " days ago"
            ,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      alignment: Alignment.centerLeft,
    );
  }

  _textItemBuild() {
    return Flexible(
      child: new Text(
        'text item testing',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
    );
  }
}
