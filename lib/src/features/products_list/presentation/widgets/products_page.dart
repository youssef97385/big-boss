import 'package:bigboss/src/core/common/widgets/app_bar_view.dart';
import 'package:bigboss/src/features/products_list/data/models/products_categories_enum.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_cubit.dart';
import 'package:bigboss/src/features/products_list/presentation/widgets/products_page_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  final int id;
  final ProductCatsEnum productCatsEnum;

  const ProductsPage({
    super.key,
    required this.id,
    required this.productCatsEnum,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ProductsListCubit>(),
      child: Scaffold(
        backgroundColor:Colors.white,
        appBar:  PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child:  AppBarView(
            appBarTitle: 'products'.tr(),
          ),
        ),
        body: ProductsPageBody(
          id: id,
          productCatsEnum: productCatsEnum,
        ),
      )
    );
  }
}
