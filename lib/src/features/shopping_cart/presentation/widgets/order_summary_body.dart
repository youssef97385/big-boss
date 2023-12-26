import 'dart:convert';
import 'dart:developer';

import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/logic/cart_cubit.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/logic/cart_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/common/widgets/alert_dialog.dart';
import '../../../../core/common/widgets/alert_dialog_view.dart';
import '../../../../core/common/widgets/button_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../../../order_feature/bloc/order_cubit.dart';
import '../../../order_feature/bloc/order_state.dart';

class OrderSummaryBody extends StatefulWidget {
  final AddressModel addressModel;

  const OrderSummaryBody({super.key, required this.addressModel});

  @override
  State<OrderSummaryBody> createState() => _OrderSummaryBodyState();
}

class _OrderSummaryBodyState extends State<OrderSummaryBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartCubit>(context).getItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return SizedBox();
      }, loading: () {
        return LoadingView();
      }, cartItems: (List<CartItemEntity> items) {
        Map<String, dynamic> addressRemark =
            json.decode(widget.addressModel.remark ?? "");
        double total = 0;
        for (CartItemEntity item in items) {
          total += (item.price * item.count);
        }
        return items.isEmpty
            ? Center(
                child: TextView(
                  text: "Your_Shopping_Cart_is_Empty".tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        TextView(
                          text: "products".tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 110,
                                      height: 150,
                                      child: Image.network(
                                        items[index].image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 280,
                                            child: TextView(
                                              text: "${items[index].name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Card(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextView(
                                                text: "${items[index].count}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextView(
                                            text: (items[index].price *
                                                            items[index].count)
                                                        .toString() +
                                                    " IQD" ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        TextView(
                          text: "Address".tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.my_location,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Flexible(
                                        child: TextView(
                                          text: "${addressRemark["area"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Flexible(
                                        child: TextView(
                                          text:
                                              "${addressRemark["street_address"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_city,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Flexible(
                                        child: TextView(
                                          text: "${addressRemark["building"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            TextView(
                              text: "Net_Total".tr(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            TextView(
                              text: "$total",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocConsumer<OrderCubit, OrderState>(
                            listener: (context, state) {
                          state.when(
                              successOrder: () {
                                BlocProvider.of<CartCubit>(context).clearCart();
                                showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.6),
                                    builder: (_) {
                                      return AlertDialogView(
                                        content:
                                            "Your_Order_Has_Been_Submitted_Successfully"
                                                .tr(),
                                      );
                                    });
                              },
                              initial: () {},
                              loading: () {},
                              error: (ErrorModel errorModel) {
                                showDialog<String>(
                                  builder: (BuildContext context) =>
                                      AlertDailogView(
                                          content: errorModel.error ?? ""),
                                  context: context,
                                );
                              });
                        }, builder: (context, state) {
                          return state.maybeWhen(orElse: () {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: Center(
                                child: SizedBox(
                                  height: 60,
                                  width: 250,
                                  child: ButtonView(
                                    buttonStyle: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                      foregroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.white),
                                    ),
                                    buttonType: ButtonType.soldButton,
                                    onClick: () async {
                                      BlocProvider.of<OrderCubit>(context)
                                          .createOrder(
                                              widget.addressModel.id ?? -1);
                                    },
                                    title: "Create_order".tr(),
                                  ),
                                ),
                              ),
                            );
                          }, loading: () {
                            return LoadingView();
                          });
                        }),
                      ],
                    ),
                  ),
                ),
              );
      });
    });
  }
}
