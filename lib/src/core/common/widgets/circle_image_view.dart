import 'package:flutter/material.dart';

class CircleImageView extends StatelessWidget {
  final String image;
  const CircleImageView({Key? key,required this.image,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: Ink.image(
        image: NetworkImage(image),
        fit: BoxFit.cover,
        width: 60.0,
        height: 60.0,

      ),
    );
  }
}
