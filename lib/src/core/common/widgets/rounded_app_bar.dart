import 'package:flutter/material.dart';
class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return  SizedBox.fromSize(
      size: preferredSize,
      child:  LayoutBuilder(builder: (context, constraint) {
        final width = constraint.maxWidth * 8;
        return  ClipRect(
          child:  OverflowBox(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
            child:  SizedBox(
              width: width,
              height: width,
              child:  Padding(
                padding:  EdgeInsets.only(
                    bottom: width / 2 - preferredSize.height / 2),
                child:   DecoratedBox(
                  decoration:  BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    shape: BoxShape.circle,

                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200.0);
}