import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/core/common/widgets/image_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_state.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/categories_cubit/categories_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/categories_cubit/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/loading_view.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return const SizedBox();
      }, success: (List<GenericEntity> categories) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "Categories",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.router.push(SubCategoriesPageAppRouter(
                            subCats: categories[index].genericEntityList ?? [],
                            catName: categories[index].name ?? ""));
                      },
                      child: SizedBox(
                        width: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 120,
                                  child: ImageBuilder(
                                    imageUrl: categories[index].image ?? "",
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              TextView(
                                  text: "${categories[index].name}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      }, error: (String error) {
        return ErrorView(error: error, onRefresh: () {});
      }, loading: () {
        return LoadingView();
      });
    });
  }
}
