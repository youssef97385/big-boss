import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/features/menu_page/presentation/logic/delete_account_bloc/delete_account_cubit.dart';
import 'package:bigboss/src/features/menu_page/presentation/logic/delete_account_bloc/delete_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/alert_dialog.dart';
import '../../../../core/common/widgets/app_bar_view.dart';
import '../../../../core/common/widgets/text_view.dart';
import '../../../../core/utils/managers/database/database_manager.dart';
import '../../../../injection.dart';
import '../../../shopping_cart/presentation/logic/cart_cubit.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccounCubit, DeleteAccountState>(
        listener: (context, state) {
      state.maybeWhen(
          orElse: () {},
          success: () {
            serviceLocator<DatabaseManager>().deleteData("token");
            BlocProvider.of<CartCubit>(context).clearCart();
            context.router.replaceAll([SplashAppRouter()]);
          },
          error: (ErrorModel err) {
            showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.6),
                builder: (_) {
                  return AlertDialogView(
                    content: err.error ?? '',
                  );
                });
          });
    }, builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Icon(
                      Icons.person,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextView(
                      text:
                          "${serviceLocator<DatabaseManager>().getData("USERNAME")}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CardView(
                      onTap: () {
                        BlocProvider.of<DeleteAccounCubit>(context)
                            .deleteAccount();
                      },
                      child: ListTile(
                        title: TextView(
                          text: "Delete your account".tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        leading: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CardView(
                      onTap: () {
                        serviceLocator<DatabaseManager>().deleteData("token");
                        BlocProvider.of<CartCubit>(context).clearCart();
                        context.router.replaceAll([SplashAppRouter()]);
                      },
                      child: ListTile(
                        title: TextView(
                          text: "Log out".tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        leading: Icon(
                          Icons.logout,
                          // color: Colors.red,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }, loading: () {
        return LoadingView();
      });
    });
  }
}
