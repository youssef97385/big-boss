import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/utils/helpers/priceFormatter.dart';
import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:bigboss/src/features/offers/domain/offer_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/routes/router.gr.dart';
import '../../../../core/common/widgets/alert_dialog.dart';
import '../../../../core/common/widgets/button_view.dart';
import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/html_widget.dart';
import '../../../../core/common/widgets/image_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../../../../core/common/widgets/text_form_field_view.dart';
import '../../../../core/common/widgets/text_view.dart';
import '../../../products_list/data/models/price_model.dart';
import '../../../products_list/domain/entiities/product_endtity.dart';
import '../../../shopping_cart/domain/entities/cart_item_entity.dart';
import '../../../shopping_cart/presentation/logic/cart_cubit.dart';
import '../logic/offer_product_cubit.dart';
import '../logic/offer_products_state.dart';

class OfferProductsPageBody extends StatefulWidget {
  final int offerId;
  final OfferEntity offerEntity;

  const OfferProductsPageBody({
    super.key,
    required this.offerId,
    required this.offerEntity,
  });

  @override
  State<OfferProductsPageBody> createState() => _OfferProductsPageBodyState();
}

class _OfferProductsPageBodyState extends State<OfferProductsPageBody> {
  ScrollController _scrollController = ScrollController();
  List<ProductEntity> productEntityList = [];
  TextEditingController countEditingController =
  TextEditingController(text: "1");
  String selectedPrice = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OfferProductsCubit>(context)
        .getProductsByOfferId(widget.offerId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferProductsCubit, OfferProductsState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return SizedBox();
          }, error: (String error) {
            return ErrorView(error: error, onRefresh: () {});
          }, loading: () {
            return LoadingView();
          }, success: (List<ProductEntity> products,) {
            log("${widget.offerEntity}");
            productEntityList = products;
            selectedPrice =
            "${getFormattedPrice((widget.offerEntity.netTotal ?? 0) *
                int.parse(countEditingController.text))}";

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    controller: _scrollController,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    padding: const EdgeInsets.all(8.0),
                    // padding around the grid
                    itemCount: products.length,
                    // total number of items
                    itemBuilder: (context, index) {
                      log("");
                      return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 135,
                                    child: ImageBuilder(
                                        imageUrl: products[index].image ?? "")),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: TextView(
                                    text: products[index].name ?? "",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    textAlignment: TextAlign.center,
                                  ),
                                ),


                              ],
                            ),
                          ));
                    },
                  ),


                  const SizedBox(height: 20,),


                  TextView(
                    text: "Offer_Description".tr(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  HtmlWidget(
                      htmlContent: widget.offerEntity.description ?? ""),


                  const SizedBox(height: 20,),
                  TextView(
                    text: "${selectedPrice}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme
                        .of(context)
                        .colorScheme
                        .primary),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 60,
                        child: TextFormFieldView(
                          onSave: (String? content) {

                          },
                          onChanged: (value){
                            setState(() {
                              selectedPrice =
                              "${getFormattedPrice((widget.offerEntity.netTotal ?? 0) *
                                  int.parse(countEditingController.text))}";
                            });

                          },
                          textEditingController: countEditingController,
                          textFormFieldTypes: TextFormFieldTypes.text,
                          hint: "",
                          maxLines: 1,
                          errorMessage: "this_field_is_required".tr(),
                          minLength: 0,
                          maxLength: 3,
                        ),

                      ),
                      const SizedBox(width: 12,),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ButtonView(
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary, // Background color
                              foregroundColor: Colors.white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    0), // Set border radius to 0 for no borders
                              ),
                            ),
                            icon: Icons.shopping_cart,
                            buttonType: ButtonType.soldButton,
                            onClick: () {
                              int count =
                              int.parse(countEditingController.text);


                              BlocProvider.of<CartCubit>(context).addItemToCart(
                                  cartItem: CartItemEntity(
                                      id: widget.offerEntity.id ?? 0,
                                      name: widget.offerEntity.name ?? "",
                                      image: widget.offerEntity.link?[0] ?? "",
                                      price: widget.offerEntity.netTotal ?? 0,
                                      isOffer: true,
                                      count: count));

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogView(
                                        content: "offer_Added_Successfully"
                                            .tr());
                                  });
                            },
                            title: "Add_offer_to_cart".tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }
}
