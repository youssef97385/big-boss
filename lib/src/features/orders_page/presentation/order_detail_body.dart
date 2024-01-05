import 'package:bigboss/src/core/common/widgets/error_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/core/utils/helpers/priceFormatter.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/order_detail_cubit.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/order_details_state.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailBody extends StatefulWidget {
  final OrderModel orderModel;

  const OrderDetailBody({
    super.key,
    required this.orderModel,
  });

  @override
  State<OrderDetailBody> createState() => _OrderDetailBodyState();
}

class _OrderDetailBodyState extends State<OrderDetailBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderDetailCubit>(context)
        .getOrder(widget.orderModel.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            BlocBuilder<OrderDetailCubit, OrderDetailState>(
                builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return SizedBox();
              }, error: (String error) {
                return ErrorView(
                    error: error,
                    onRefresh: () {
                      BlocProvider.of<OrderDetailCubit>(context)
                          .getOrder(widget.orderModel.id ?? 0);
                    });
              }, loading: () {
                return LoadingView();
              }, success: (List<ProductEntity> products) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(text: "Order number: ${widget.orderModel.id}",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),),

                        ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextView(text: "Product#${index+1}: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),

                                      Flexible(child: TextView(text: "${products[index].name}",style: Theme.of(context).textTheme.titleMedium,))
                                    ],
                                  ));
                            }),

                        TextView(text: "Net total: ${getFormattedPrice(widget.orderModel.netTotal??0)}",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),),

                      ],
                    ),
                  ),
                );
              });
            }),
          ],
        ),
      ),
    );
  }
}
