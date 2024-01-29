import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/new_products_cubit/new_products_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/new_products_cubit/new_products_state.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/image_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../../../../core/common/widgets/offer_product_widget.dart';
import '../../../../core/common/widgets/product_widget.dart';
import '../../../../core/common/widgets/text_view.dart';

class NewProductsWidget extends StatelessWidget {
  const NewProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewProductsCubit, NewProductsState>(
        builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return SizedBox();
      }, error: (String error) {
        return ErrorView(error: error, onRefresh: () {});
      }, loading: () {
        return LoadingView();
      }, success: (List<ProductEntity> products) {
        List limitedProducts = [];

        if (products.length < 10) {
          limitedProducts = products;
        } else {
          limitedProducts = products.sublist(0, 10);
        }
        return Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            TextView(
              text: "New Products".tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            const SizedBox(height: 16,),
            GridView.builder(
              itemCount: limitedProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 3
                        : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: (0.85),
              ),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (
                context,
                index,
              ) {
                return ProductWidget(productEntity: limitedProducts[index],);
              },

            )

          ],
        );
      });
    });
  }
}
