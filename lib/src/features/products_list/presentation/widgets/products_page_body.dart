import 'dart:developer';

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
import '../../../../core/common/widgets/product_widget.dart';
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
  ScrollController _scrollController = ScrollController();
  List<ProductEntity> productEntityList = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsListCubit>(context).getProducts(
      id: widget.id,
      productCatsEnum: widget.productCatsEnum,
      pageNumber: 1,
    );
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<ProductsListCubit>(context).getProducts(
        id: widget.id,
        productCatsEnum: widget.productCatsEnum,
        pageNumber: page + 1,
      );
    }
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
      }, success: (List<ProductEntity> products, pageNumber, totalPages) {
        productEntityList = products;
        page = pageNumber;
        return     Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: GridView.builder(
            controller: _scrollController,
            itemCount: productEntityList.length,
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
              return ProductWidget(productEntity: productEntityList[index],);
            },

          ),
        );
      });
    });
  }
}
