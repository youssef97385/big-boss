import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
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
import 'package:bigboss/src/features/shopping_cart/presentation/widgets/order_summary_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/alert_dialog_view.dart';
import '../logic/cart_state.dart';

class OrderSummary extends StatefulWidget {
  final AddressModel addressModel;

  const OrderSummary({
    super.key,
    required this.addressModel,
  });

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: AppBarView(
            appBarTitle: 'Order_Summary'.tr(),
          ),
        ),
        body: BlocProvider(
          create: (context) => serviceLocator<CartCubit>(),
          child: OrderSummaryBody(
            addressModel: widget.addressModel,
          ),
        ));
  }
}
