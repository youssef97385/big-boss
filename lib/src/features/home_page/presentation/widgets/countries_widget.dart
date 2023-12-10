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
            TextView(
              text: "Countries",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 104,
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
                      child: Column(
                        children: [
                          Container(
                            height: 80.0,
                            width: 80.0,
                            margin:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  entity[index].image ?? "",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextView(
                              text: "${entity[index].name}",
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
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
