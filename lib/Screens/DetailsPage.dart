import 'package:flutter/material.dart';
import '../Widgets/Button.dart';

class ImageView extends StatefulWidget {
  final String imgPath;
  /*imgPath representing the URL of an image*/
  const ImageView({super.key, required this.imgPath});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*The first child of the Stack is a Hero widget,
        which displays the image using the URL passed in as imgPath. The Hero widget is given a tag that identifies it as the same image that is being displayed in the previous screen.
        This allows for a smooth hero transition animation between the two screens.*/
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgPath,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imgPath, fit: BoxFit.cover)
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Button(),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

