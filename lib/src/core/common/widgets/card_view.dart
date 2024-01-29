import 'package:flutter/material.dart';

import '../../../injection.dart';

class CardView extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final double elevation;
  final double radius;
  const CardView({
    this.onTap,
    required this.child,
    Key? key,
    this.color,
    this.elevation = 2,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: InkWell(
        onTap: onTap != null
            ? () {

                onTap!();
              }
            : null,
        child: child,
      ),
    );
  }
}
