import 'package:flutter/material.dart';
import 'text_view.dart';

import 'button_view.dart';
import 'image_view.dart';

class DetailDialog extends StatelessWidget {

  final String? imagePath;
  final String? title;
  final String? detail;



  const DetailDialog({
    Key? key,
    this.title,
    this.detail,
    this.imagePath,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      scrollable: true,
      title: SizedBox(
        height: 280,
        child: ImageBuilder(
          imageUrl: imagePath ?? "",
        ),
      ),
      content: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 12,
            ),
            TextView(
              text: detail ?? '',
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
      actions: <Widget>[
        ButtonView(
          buttonType: ButtonType.soldButton,
          onClick: () => Navigator.pop(context),
          title: "OK",
        )
      ],
    );
  }
}
