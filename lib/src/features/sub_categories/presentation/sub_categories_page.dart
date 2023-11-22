import 'package:bigboss/src/features/sub_categories/presentation/logic/sub_category_cubit/sub_category_cubit.dart';
import 'package:bigboss/src/features/sub_categories/presentation/sub_category_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/domain/entites/generic_entity.dart';
import '../../../core/common/widgets/app_bar_view.dart';
import '../../../core/common/widgets/text_view.dart';

class SubCategoriesPage extends StatefulWidget {
  final List<GenericEntity> subCats;
  final String catName;

  const SubCategoriesPage({
    super.key,
    required this.subCats,
    required this.catName,
  });

  @override
  State<SubCategoriesPage> createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: AppBarView(
            appBarTitle: widget.catName,
          ),
        ),
        body: BlocProvider(
          create: (context) => serviceLocator<SubCategoryCubit>(),
          child: SubCategoryBody(
            subCats: widget.subCats,
          ),
        ));
  }
}
