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
import '../../core/common/widgets/product_widget.dart';
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

                      itemCount: products.length,
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
                        return ProductWidget(productEntity: products[index],);
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
