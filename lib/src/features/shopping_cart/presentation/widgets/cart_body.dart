import 'dart:developer';

import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/logic/cart_cubit.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/logic/cart_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loading_view.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return SizedBox();
      }, loading: () {
        return LoadingView();
      }, cartItems: (List<CartItemEntity> items) {
   
        return items.isEmpty
            ? Center(
              child: TextView(
                  text: "Your_Shopping_Cart_is_Empty".tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
            )
            : Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListView.builder(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 300,
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
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextView(
                                        text: "${items[index].count}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextView(
                                    text: (items[index].price*items[index].count).toString() +
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
                            Spacer(),
                            InkWell(
                              onTap: (){
                                BlocProvider.of<CartCubit>(context).deleteItemFromCart(cartItem: items[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.delete,color: Colors.grey,),
                              ),
                            )

                          ],
                        ),
                      );
                    }),
              );
      });
    });
  }
}
