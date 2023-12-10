import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/common/widgets/image_view.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/sub_categories/presentation/logic/sub_category_cubit/sub_category_cubit.dart';
import 'package:bigboss/src/features/sub_categories/presentation/logic/sub_category_cubit/sub_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes/router.gr.dart';
import '../../../core/common/domain/entites/generic_entity.dart';
import '../../../core/common/widgets/error_view.dart';
import '../../../core/common/widgets/loading_view.dart';
import '../../../core/common/widgets/text_view.dart';

class SubCategoryBody extends StatefulWidget {
  final List<GenericEntity> subCats;

  const SubCategoryBody({
    super.key,
    required this.subCats,
  });

  @override
  State<SubCategoryBody> createState() => _SubCategoryBodyState();
}

class _SubCategoryBodyState extends State<SubCategoryBody> {
  ScrollController _scrollController = ScrollController();
  int chosenIndex = 0;
int pageNumber = 1;
  @override
  void initState() {
    super.initState();
    if (widget.subCats.isNotEmpty) {
      BlocProvider.of<SubCategoryCubit>(context)
          .getProductsBySubCategory(id: widget.subCats[0].id ?? 0,page: 1);
    }
    _scrollController.addListener(_loadMoreData);
  }
  void _loadMoreData() {

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<SubCategoryCubit>(context).getProductsBySubCategory(
        id: widget.subCats[chosenIndex].id ??0,
        page: pageNumber+1,

      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(

            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            // padding around the grid
            itemCount: widget.subCats.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    chosenIndex = index;
                    pageNumber = 1;
                    BlocProvider.of<SubCategoryCubit>(context)
                        .getProductsBySubCategory(
                            id: widget.subCats[index].id ?? 0,page: 1);
                  });
                },
                child: Card(
                  color: chosenIndex == index
                      ? Theme.of(context).colorScheme.secondary
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: TextView(
                      text: widget.subCats[index].name ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<SubCategoryCubit, SubCategoryState>(
            builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const SizedBox();
          }, error: (String error) {
            return ErrorView(error: error, onRefresh: () {});
          }, loading: () {
            return LoadingView();
          }, success: (List<ProductEntity> products,page,total) {
            pageNumber = page;
            return Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
                padding: EdgeInsets.all(8.0), // padding around the grid
                itemCount: products.length, // total number of items
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.router.push(ProductScreenAppRouter(
                          productEntity: products[index]));
                    },
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 150,
                              child: ImageBuilder(
                                  imageUrl: products[index].image ?? "")),
                          const SizedBox(
                            height: 12,
                          ),
                          TextView(
                            text: products[index].name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                  );
                },
              ),
            );
          });
        })
      ],
    );
  }
}
