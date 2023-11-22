import 'package:flutter/material.dart';

import '../../constants/image_name.dart';

class LogoView extends StatelessWidget {
  final double logoSize;
  final Color? logoColor;

  LogoView({
    this.logoSize = 100,
    this.logoColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageNameHelper.getValue(
        ImageName.logo,

      ),
      fit: BoxFit.contain,
      height: logoSize,
      width: logoSize,
    );
  }
}
