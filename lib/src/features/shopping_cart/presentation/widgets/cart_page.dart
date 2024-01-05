import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/logic/app_settings.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/common/widgets/alert_dialog.dart';
import 'package:bigboss/src/core/common/widgets/app_bar_view.dart';
import 'package:bigboss/src/core/common/widgets/button_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:bigboss/src/features/order_feature/bloc/order_cubit.dart';
import 'package:bigboss/src/features/order_feature/bloc/order_state.dart';
import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/logic/cart_cubit.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/widgets/cart_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/alert_dialog_view.dart';
import '../../../../core/utils/helpers/priceFormatter.dart';
import '../logic/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  AddressModel? addressModel;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        return state.maybeWhen(orElse: () {
          return SizedBox();
        }, cartItems: (items) {
          return items.isEmpty
              ? SizedBox()
              : SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextView(
                              text: "Net_Total".tr(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) {
                              return state.maybeWhen(orElse: () {
                                return SizedBox();
                              }, loading: () {
                                return LoadingView();
                              }, cartItems: (List<CartItemEntity> items) {
                                double total = 0;
                                for (CartItemEntity item in items) {
                                  total += (item.price * item.count);
                                }
                                return TextView(
                                  text: "${getFormattedPrice(total)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                );
                              });
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 60,
                          width: 340,
                          child: ButtonView(
                            buttonStyle: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 20),
                                foregroundColor: Colors.white,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondary),
                            title: "Choose_address".tr(),
                            buttonType: ButtonType.soldButton,
                            onClick: () async {

                              if(serviceLocator<AppSettings>().token == null){
                                showDialog(context: context, builder: (context){
                                  return AlertDialogView(content:"Please_login_first" );
                                });
                              }else{
                                await context.router
                                    .push(AddressListAppRouter());
                              }



                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
        });
      }),
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, 60),
      //   child: AppBarView(
      //     appBarTitle: "Cart",
      //   ),
      // ),
      body: CartBody(),
    );
  }
}
