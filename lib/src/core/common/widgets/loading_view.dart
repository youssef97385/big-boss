import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingView extends StatelessWidget {
  double loadingSize;
  Color? loadingColor;
  LoadingView({
    this.loadingSize = 50,
    this.loadingColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LoadingBouncingLine.circle(

      ),
    );
  }
}
