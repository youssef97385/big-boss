import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/core/common/widgets/image_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/routes/router.gr.dart';
import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../../../products_list/data/models/products_categories_enum.dart';

class BrandsWidget extends StatelessWidget {
  const BrandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsCubit, BrandsState>(builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return const SizedBox();
      }, success: (List<GenericEntity> brands) {
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
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 8,
                ),
                TextView(
                  text: "Brand".tr(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          context.router.push(ProductsPageAppRouter(
                              id: brands[index].id ?? 0,
                              productCatsEnum: ProductCatsEnum.brand));
                        },
                        child: SizedBox(
                          width: 140,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 70,
                                    child: ImageBuilder(
                                      fit: BoxFit.cover,
                                      imageUrl: "${brands[index].image}",
                                    )),
                              ],
                            ),
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
