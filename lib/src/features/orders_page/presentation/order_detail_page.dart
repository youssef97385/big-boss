import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/app_bar_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/order_detail_cubit.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/orders_bloc.dart';
import 'package:bigboss/src/features/orders_page/presentation/order_detail_body.dart';
import 'package:bigboss/src/features/orders_page/presentation/orders_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/logic/app_settings.dart';
import '../../../core/common/widgets/button_view.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderModel orderModel;

  const OrderDetailPage({
    super.key,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: AppBarView(
            appBarTitle: "Order Detail",
          ),
        ),
        body: BlocProvider(
          create: (context) => serviceLocator<OrderDetailCubit>(),
          child: OrderDetailBody(
            orderModel: orderModel,
          ),
        ));
  }
}
