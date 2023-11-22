
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/const.dart';

import 'text_view.dart';

class AppBarView extends StatelessWidget {
  final String appBarTitle;
  final Widget? customeOption;


  const AppBarView({
    Key? key,
    required this.appBarTitle,
     this.customeOption,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:  Image.asset('assets/images/big-boss-splash-logo.png'),
      leadingWidth: 80,
      titleSpacing: 0.0,
      title: Center(
        child: TextView(
          text: appBarTitle,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      actions: [
        customeOption!=null?
       customeOption!:SizedBox(),
      ],
    );
  }
}
