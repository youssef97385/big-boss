import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/image_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_cubit.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../../data/models/products_categories_enum.dart';

class ProductsPageBody extends StatefulWidget {
  final int id;
  final ProductCatsEnum productCatsEnum;

  const ProductsPageBody({
    super.key,
    required this.id,
    required this.productCatsEnum,
  });

  @override
  State<ProductsPageBody> createState() => _ProductsPageBodyState();
}

class _ProductsPageBodyState extends State<ProductsPageBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsListCubit>(context)
        .getProducts(id: widget.id, productCatsEnum: widget.productCatsEnum);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsListCubit, ProductsListState>(
        builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return const SizedBox();
      }, error: (String error) {
        return ErrorView(error: error, onRefresh: () {});
      }, loading: () {
        return LoadingView();
      }, success: (List<ProductEntity> products) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          padding: const EdgeInsets.all(8.0), // padding around the grid
          itemCount: products.length, // total number of items
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.router.push(
                    ProductScreenAppRouter(productEntity: products[index]));
              },
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                        height: 135,
                        child: ImageBuilder(
                            imageUrl: products[index].image ?? "")),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 30,
                      child: TextView(
                        text: products[index].name ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlignment: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextView(
                      text: products[index].priceLabel,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                      textAlignment: TextAlign.center,
                    ),
                  ],
                ),
              )),
            );
          },
        );
      });
    });
  }
}
