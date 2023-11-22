import 'package:flutter/material.dart';

import '../../../injection.dart';

class CardView extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final double elevation;
  const CardView({
    this.onTap,
    required this.child,
    Key? key,
    this.color,
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(0)),
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
