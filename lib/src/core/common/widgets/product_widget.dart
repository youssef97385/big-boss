import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:flutter/material.dart';

import '../../../app/routes/router.gr.dart';
import 'image_view.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductWidget({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    final bool isDiscountAvailable = productEntity.discountPercentage != 0 &&
        productEntity.discountPercentage != null;

    return InkWell(
      onTap: () {
        context.router
            .push(ProductScreenAppRouter(productEntity: productEntity));
      },
      child: CardView(
        elevation: 0.8,
        radius: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  height:150,
                  child: ImageBuilder(imageUrl: productEntity.image ?? "")),
              TextView(
                text: productEntity.name ?? "",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    fontSize: 16,
                    color: Color(0xFF262626)),
                textAlignment: TextAlign.start,
                maxLines: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isDiscountAvailable,
                    child: TextView(
                      text: productEntity.priceLabelAfterDiscount,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Visibility(
                      visible: isDiscountAvailable,
                      child: const SizedBox(
                        width: 16,
                      )),
                  TextView(
                    text: productEntity.priceLabel,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        decoration: isDiscountAvailable
                            ? TextDecoration.lineThrough
                            : null,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color:
                        isDiscountAvailable ? Colors.grey : Colors.black),
                    textAlignment: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
