import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:bigboss/src/features/offers/domain/offer_entity.dart';
import 'package:bigboss/src/features/offers/presentation/logic/offer_product_cubit.dart';
import 'package:bigboss/src/features/offers/presentation/widgets/offers_products_page_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/app_bar_view.dart';

class OfferProductsPage extends StatelessWidget {
  final int offerId;
  final OfferEntity offerEntity;

  const OfferProductsPage({
    super.key,
    required this.offerId,
    required this.offerEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBarView(
          appBarTitle: 'products'.tr(),
        ),
      ),
      body: BlocProvider(
        create: (context) => serviceLocator<OfferProductsCubit>(),
        child: OfferProductsPageBody(
          offerId: offerId,
          offerEntity: offerEntity,
        ),
      ),
    );
  }
}
