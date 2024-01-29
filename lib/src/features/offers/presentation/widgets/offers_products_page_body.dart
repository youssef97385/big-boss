import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/utils/helpers/priceFormatter.dart';
import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:bigboss/src/features/offers/domain/offer_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/routes/router.gr.dart';
import '../../../../core/common/widgets/alert_dialog.dart';
import '../../../../core/common/widgets/button_view.dart';
import '../../../../core/common/widgets/error_view.dart';
import '../../../../core/common/widgets/html_widget.dart';
import '../../../../core/common/widgets/image_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../../../../core/common/widgets/offer_product_widget.dart';
import '../../../../core/common/widgets/text_form_field_view.dart';
import '../../../../core/common/widgets/text_view.dart';
import '../../../../core/utils/helpers/date_formatter.dart';
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
      }, success: (
        List<ProductEntity> products,
      ) {
        productEntityList = products;
        selectedPrice =
            "${getFormattedPrice((widget.offerEntity.netTotal ?? 0) * int.parse(countEditingController.text))}";

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextView(
                  text: "${widget.offerEntity.name}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 24),
                ),
                HtmlWidget(htmlContent: widget.offerEntity.description ?? ""),
                const SizedBox(
                  height: 26,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/icons/date_icon.svg",
                      width: 28,
                      height: 28,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Row(
                      children: [
                        TextView(
                          text: "start: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey, fontSize: 18),
                        ),
                        TextView(
                          text: widget.offerEntity.startDateText ?? "",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        TextView(
                          text: "end: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey, fontSize: 18),
                        ),
                        TextView(
                          text: widget.offerEntity.endDateText ?? "",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
            
                ListView.builder(
                  shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context,index){
            
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(text:"Product ${index+1}",style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18,fontWeight: FontWeight.normal),),
                          TextView(text: products[index].remark ??"",style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    );
            
                }),

            
                GridView.builder(

                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio:0.73,
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 4.0, // spacing between rows
                    crossAxisSpacing: 16.0, // spacing between columns
                  ),
                  padding: const EdgeInsets.all(20.0),
                  // padding around the grid
                  itemCount: products.length,
                  // total number of items
                  itemBuilder: (context, index) {
                    return OfferProductWidget(productEntity: products[index],);
                  },
                ),


                const SizedBox(
                  height: 20,
                ),
                TextView(
                  text: "${selectedPrice}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 90,
                      height: 60,
                      child: TextFormFieldView(
                        onSave: (String? content) {},
                        onChanged: (value) {
                          setState(() {
                            selectedPrice =
                                "${getFormattedPrice((widget.offerEntity.netTotal ?? 0) * int.parse(countEditingController.text))}";
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
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ButtonView(
                          buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: Color(  0xFF538560,), // Background color
                            foregroundColor: Colors.white, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  6), // Set border radius to 0 for no borders
                            ),
                          ),
                          icon: Icons.shopping_cart,
                          buttonType: ButtonType.soldButton,
                          onClick: () {
                            int count = int.parse(countEditingController.text);
            
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
                                      content: "offer_Added_Successfully".tr());
                                });
                          },
                          title: "Add_offer_to_cart".tr(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ),
        );
      });
    });
  }
}
