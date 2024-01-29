import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:flutter/material.dart';

import 'image_view.dart';

class OfferProductWidget extends StatelessWidget {
  final ProductEntity productEntity;

  const OfferProductWidget({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 152,
            child: CardView(
                radius: 8,
                elevation: 0.9,
                child: SizedBox(
                    height: 152,
                    // width: 160,
                    child: ImageBuilder(imageUrl: productEntity.image ?? ""))),
          ),
          const SizedBox(
            height: 12,
          ),
          TextView(
            text: productEntity.name ?? "",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                height: 1.3,
                fontSize: 14,
                color: Color(0xFF262626)),
            textAlignment: TextAlign.start,
          ),
          TextView(
            text: productEntity.remark ?? "",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.3,
                fontSize: 16,
                color: Color(0xFF262626)),
            textAlignment: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
