import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/error_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/core/utils/helpers/date_formatter.dart';
import 'package:bigboss/src/core/utils/helpers/format_order_status.dart';
import 'package:bigboss/src/core/utils/helpers/priceFormatter.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/orders_bloc.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/orders_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextView(
              text: "My_Orders".tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return SizedBox();
              }, error: (String error) {
                return ErrorView(
                    error: error,
                    onRefresh: () {
                      BlocProvider.of<OrdersBloc>(context).getOrders();
                    });
              }, loading: () {
                return LoadingView();
              }, success: (List<OrderModel> orders) {
                return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.router.push(OrderDetailPageAppRouter(
                              orderModel: orders[index]));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          TextView(
                                              text: "Status".tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          TextView(
                                              text: getFormattedOrderStatus(
                                                  orders[index].orderStatus ??
                                                      5),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(color: Colors.red)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          TextView(
                                              text: "net_total".tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          TextView(
                                              text: getFormattedPrice(
                                                  orders[index].netTotal ?? 0),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Colors.green)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          TextView(
                                              text: "Date".tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          TextView(
                                              text:
                                                  "${formatDate(orders[index].dateTime)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Colors.green)),
                                        ],
                                      ),
                                    ]),
                                Row(
                                  children: [
                                    TextView(
                                        text: "Order".tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.green)),
                                    TextView(
                                        text: "#${orders[index].id}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.green)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              });
            }),
          ],
        ),
      ),
    );
  }
}
