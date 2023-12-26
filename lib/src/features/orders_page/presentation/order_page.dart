import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/orders_bloc.dart';
import 'package:bigboss/src/features/orders_page/presentation/orders_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/logic/app_settings.dart';
import '../../../core/common/widgets/button_view.dart';
import '../../../core/common/widgets/error_view.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => serviceLocator<OrdersBloc>(),
        child: Visibility(
            visible: serviceLocator<AppSettings>().token?.isNotEmpty  ?? false,
            child: OrdersBody(),replacement: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.error,size: 120,color: Theme.of(context).colorScheme.primary,),
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextView(
                  text: "to_see_your_orders_please_login_first".tr(),
                  textAlignment: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3?.copyWith(height: 1.6),
                ),
              ),
              const SizedBox(height: 21.0),
              ButtonView(
                buttonType: ButtonType.soldButton,
                title: "Go_to_login".tr(),
                onClick: (){
                  context.router.push(LoginPageAppRouter());
                },

              ),

            ],
          ),
        ),),
      ),
    );
  }
}
