import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class HtmlWidget extends StatelessWidget {
  final String htmlContent;

  const HtmlWidget({Key? key, required this.htmlContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlContent,
      style: {
        "body": Style(
          fontSize: FontSize(16.0),
          fontWeight: FontWeight.normal,
          maxLines: null,
          lineHeight: LineHeight.normal,
          fontFamily: 'GothamBook',
        ),
      },

    );
  }
}
