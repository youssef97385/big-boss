import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/common/widgets/image_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/offers/domain/offer_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/routes/router.gr.dart';
import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../logic/offers_bloc.dart';
import '../logic/offers_state.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocBuilder<OffersCubit, OffersState>(builder: (context, state) {
        return state.maybeWhen(orElse: () {
          return const SizedBox();
        }, success: (List<OfferEntity> offers) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextView(
                text: "New_Offers".tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              offers.length > 2
                  ? Row(
                      children: [
                        OfferWidget(
                          offer: offers[0],
                          height: 240,
                          width: 200,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            OfferWidget(
                              offer: offers[1],
                              height: 118,
                              width: 200,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            OfferWidget(
                              offer: offers[2],
                              height: 118,
                              width: 200,
                            ),
                          ],
                        ),
                      ],
                    )
                  : offers.length == 2
                      ? Row(
                          children: [
                            OfferWidget(
                              offer: offers[0],
                              height: 240,
                              width: 200,
                            ),
                            OfferWidget(
                              offer: offers[1],
                              height: 240,
                              width: 200,
                            ),
                          ],
                        )
                      : OfferWidget(
                          offer: offers[0],
                          height: 240,
                          width: double.infinity,
                        ),
            ],
          );
        }, error: (String error) {
          return ErrorView(
              error: error,
              onRefresh: () {
                BlocProvider.of<OffersCubit>(context).getOffers();
              });
        }, loading: () {
          return LoadingView();
        });
      }),
    );
  }
}

class OfferWidget extends StatelessWidget {
  final double height;
  final double width;
  final OfferEntity offer;

  const OfferWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.offer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xFFE0EBE1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          height: height,
          width: width,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8),
          child: InkWell(
              onTap: () {
                context.router.push(
                  OfferProductsPageAppRouter(
                    offerId: offer.id ?? 0,
                    offerEntity: offer,
                  ),
                );
              },
              child: Column(
                children: [
                  Visibility(
                    visible: offer.link?[0]
                            ?.substring((offer.link?[0]?.length ?? 0) - 4) ==
                        "avif",
                    replacement: SizedBox(
                        height: height,
                        width: width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: ImageBuilder(
                              imageUrl: offer.link?[0] ?? "", fit: BoxFit.fill),
                        )),
                    child: SizedBox(
                      height: 120,
                      child: AvifImage.network(
                        offer.link?[0] ?? "",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
