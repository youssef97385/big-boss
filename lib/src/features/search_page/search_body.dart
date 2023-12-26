import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/image_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_cubit.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_state.dart';
import 'package:bigboss/src/features/search_page/cubit/search_cubit.dart';
import 'package:bigboss/src/features/search_page/cubit/search_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/common/widgets/error_view.dart';
import '../../core/common/widgets/loading_view.dart';
import '../../core/common/widgets/text_form_field_view.dart';

class SearchBody extends StatefulWidget {

  const SearchBody({
    super.key,
  });

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {


  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      if(searchController.text.length > 2){
        BlocProvider.of<SearchCubit>(context).search(
            value: searchController.text
        );
      }else if(searchController.text.length==0){
        BlocProvider.of<SearchCubit>(context).clear(

        );
      }
    });

  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TextFormFieldView(
            onSave: (String? content) {

            },
            textEditingController: searchController,
            textFormFieldTypes: TextFormFieldTypes.text,
            hint: "Type_here".tr(),
            maxLines: 1,
            errorMessage: "this_field_is_required".tr(),
            minLength: 0,
            prefixIcon: Icon(Icons.search),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return const SizedBox();
                  }, error: (String error) {
                    return ErrorView(error: error, onRefresh: () {
                      BlocProvider.of<SearchCubit>(context).search(
                       value: searchController.text
                      );

                    });
                  }, loading: () {
                    return LoadingView();
                  }, success: (List<ProductEntity> products,) {

                    return GridView.builder(

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // number of items in each row
                        mainAxisSpacing: 8.0, // spacing between rows
                        crossAxisSpacing: 2.0, // spacing between columns
                      ),
                      padding: const EdgeInsets.all(8.0),
                      // padding around the grid
                      itemCount: products.length,
                      // total number of items
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
                                        height: 100,
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
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 22,
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
                }),
          ),
        ],
      ),
    );
  }
}
