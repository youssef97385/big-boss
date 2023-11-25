import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/orders_bloc.dart';
import 'package:bigboss/src/features/orders_page/presentation/orders_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => serviceLocator<OrdersBloc>(),
        child: OrdersBody(),
      ),
    );
  }
}
