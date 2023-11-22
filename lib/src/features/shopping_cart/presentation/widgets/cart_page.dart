import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/common/widgets/app_bar_view.dart';
import 'package:bigboss/src/core/common/widgets/button_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/features/order_feature/bloc/order_cubit.dart';
import 'package:bigboss/src/features/order_feature/bloc/order_state.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/logic/cart_cubit.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/widgets/cart_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/alert_dialog_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:
      BlocConsumer<OrderCubit, OrderState>(listener: (context, state) {
        print("STATE is Success $state");
        state.when(
            successOrder: () {
              BlocProvider.of<CartCubit>(context).clearCart();
            },
            initial: () {},
            loading: () {},
            error: (ErrorModel errorModel) {
              showDialog<String>(
                builder: (BuildContext context) =>
                    AlertDailogView(content: errorModel.error ?? ""),
                context: context,
              );
            });
      }, builder: (context, state) {
        return state.maybeWhen(
            orElse: () {
              return SizedBox(
                height: 60,
                width: 340,
                child: ButtonView(
                  title: "Place Order",
                  buttonType: ButtonType.soldButton,
                  onClick: () {
                    BlocProvider.of<OrderCubit>(context).createOrder();
                  },
                ),
              );
            },
            loading: () {
              return LoadingView();
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
