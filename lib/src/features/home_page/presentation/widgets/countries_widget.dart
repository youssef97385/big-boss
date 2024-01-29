import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_state.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/categories_cubit/categories_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/categories_cubit/categories_state.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/countries_cubit/countries_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/countries_cubit/countries_state.dart';
import 'package:bigboss/src/features/products_list/data/models/products_categories_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/loading_view.dart';

class CountriesWidget extends StatelessWidget {
  const CountriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesCubit, CountriesState>(
        builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return const SizedBox();
      }, success: (List<GenericEntity> entity) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextView(
                  text: "Find Suppliers by Country".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold,fontSize: 20),
                ),
                const SizedBox(
                  width: 8,
                ),
                TextView(
                  text: "Countries".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary,fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 55,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: entity.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.router.push(ProductsPageAppRouter(
                            id: entity[index].id ?? 0,
                            productCatsEnum: ProductCatsEnum.country));
                      },
                      child: Container(
                        height: 45.0,
                        width: 70.0,
                        margin:
                            const EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(


                          image: DecorationImage(

                            fit: BoxFit.fill,
                            image: NetworkImage(
                              entity[index].image ?? "",

                            ),
                          ),
                        ),
                      ),
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 140,
                        child: CardView(
                            onTap: () {
                              context.router.push(ProductsPageAppRouter(
                                  id: entity[index].id ?? 0,
                                  productCatsEnum: ProductCatsEnum.country));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 120,
                                      child: Image.network(
                                        entity[index].image ?? "",
                                        fit: BoxFit.fill,
                                      )),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextView(
                                      text: "${entity[index].name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            )),
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
