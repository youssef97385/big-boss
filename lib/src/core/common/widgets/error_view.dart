import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'button_view.dart';
import 'logo_view.dart';
import 'text_view.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRefresh;

  final double? logoSize;

  const ErrorView({

    required this.error,
    required this.onRefresh,
    this.logoSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LogoView(logoSize:logoSize ?? 40),
          const SizedBox(height: 18.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextView(
              text: error,
              textAlignment: TextAlign.center,
              style: Theme.of(context).textTheme.headline3?.copyWith(height: 1.6),
            ),
          ),
          const SizedBox(height: 21.0),
          ButtonView(
            buttonType: ButtonType.soldButton,
            title: "Refresh".tr(),
            onClick: onRefresh,
            icon: Icons.refresh,
          ),
          const SizedBox(height: 4.0),
          ButtonView(
            buttonType: ButtonType.textButton,
            title: "Contact_Us_Tab".tr(),
            onClick: () {
              context.router.pushNamed('contactus');
            },
          ),
        ],
      ),
    );
  }
}
