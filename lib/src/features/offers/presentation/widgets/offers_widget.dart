import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/core/common/widgets/image_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/accounts_cubit/accounts_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/accounts_cubit/accounts_state.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_state.dart';
import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:bigboss/src/features/offers/domain/offer_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/routes/router.gr.dart';
import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../../../products_list/data/models/products_categories_enum.dart';
import '../logic/offers_bloc.dart';
import '../logic/offers_state.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersState>(builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return const SizedBox();
      }, success: (List<OfferEntity> offers) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "New_Offers".tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 170,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 150,
                        child: CardView(
                            onTap: () {
                              context.router.push(
                                OfferProductsPageAppRouter(
                                  offerId: offers[index].id ?? 0,
                                  offerEntity: offers[index],
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Visibility(
                                  visible: offers[index].link?[0]?.substring(
                                          (offers[index].link?[0]?.length ?? 0) -
                                              4) ==
                                      "avif",
                                  replacement: SizedBox(
                                      height: 120,
                                      child: ImageBuilder(
                                        imageUrl: offers[index].link?[0] ?? "",
                                      )),
                                  child: SizedBox(
                                    height: 120,
                                    child: AvifImage.network(
                                      offers[index].link?[0] ?? "",
                                      height: 200,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextView(
                                  text: "${offers[index].enName}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlignment: TextAlign.center,
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
            ),
          ],
        );
      }, error: (String error) {
        return ErrorView(error: error, onRefresh: () {
          BlocProvider.of<OffersCubit>(context).getOffers();
        });
      }, loading: () {
        return LoadingView();
      });
    });
  }
}
