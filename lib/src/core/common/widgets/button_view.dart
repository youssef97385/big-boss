import 'package:flutter/material.dart';

import '../../../injection.dart';
import 'text_view.dart';

enum ButtonType { soldButton, outlinedButton, textButton, iconButton }

class ButtonView extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final ButtonType buttonType;
  final VoidCallback onClick;
  final ButtonStyle? buttonStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? width;

  const ButtonView({
    this.title,
    this.icon,
    this.buttonStyle,
    required this.buttonType,
    required this.onClick,
    this.iconColor,
    this.textColor,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.soldButton:
        return soldButton(context);
      case ButtonType.outlinedButton:
        return outlineButton(context);
      case ButtonType.textButton:
        return textButton(context);
      case ButtonType.iconButton:
        return iconButton(context);
    }
  }

  Widget soldButton(BuildContext context) {
    return ElevatedButton(

      onPressed: () {

        onClick();
      },
      style: buttonStyle,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null) Icon(icon , color: iconColor,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
              child: TextView(text: title ?? '' , style:  TextStyle(color: textColor),),
            ),
          ],
        ),
      ),
    );
  }

  Widget outlineButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {

        onClick();
      },
      style: buttonStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          TextView(text: title ?? ''),
        ],
      ),
    );
  }

  Widget textButton(BuildContext context) {
    return TextButton(
      onPressed: () {

        onClick();
      },
      style: buttonStyle,
      child: TextView(text: title ?? '' , style:  TextStyle(color: textColor),),
    );
  }

  Widget iconButton(BuildContext context) {
    return IconButton(
      onPressed: () {

        onClick();
      },
      icon: Icon(
        icon ?? Icons.add_box,
        color: iconColor,
      ),
    );
  }
}
