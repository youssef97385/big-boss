import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/alert_dialog.dart';
import 'package:bigboss/src/core/common/widgets/button_view.dart';
import 'package:bigboss/src/core/common/widgets/html_widget.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/products_list/data/models/price_model.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/logic/cart_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/app_bar_view.dart';
import '../../../../core/common/widgets/text_form_field_view.dart';

class ProductScreen extends StatefulWidget {
  final ProductEntity? productEntity;

  ProductScreen({
    Key? key,
    this.productEntity,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Color> colors = [
    const Color(0xffffffff),
    const Color(0xffA6B7E8),
    const Color(0xffF2D750),
    const Color(0xff000000)
  ];

  String? selectedImage, selectedPrice;

  int selectedSize = -1;
  int selectedColor = -1;
  int selectedNumber = 1;
  bool isProductAdded = false;
  TextEditingController countEditingController =
      TextEditingController(text: "1");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: AppBarView(
          appBarTitle: '',
          customeOption: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () {
                context.router.push(const CartPageAppRouter());
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 30,
                  ),
                  isProductAdded
                      ? Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextView(
                              text: "1",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:
            // state.product==null?Container():
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(14),
                        bottomLeft: Radius.circular(14)),
                  ),
                  child: (widget.productEntity?.image?.isEmpty ?? true)? SizedBox(): ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14)),
                      child: Hero(
                        tag: "${widget.productEntity?.id}",
                        child: Image.network(
                          "${widget.productEntity?.image}",
                          fit: BoxFit.contain,
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///price

                  TextView(
                    text: "${widget.productEntity?.name}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextView(
                    text: "${widget.productEntity?.highestPrice}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 18,
                  ),

                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productEntity?.sizes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = index;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                // width: 40,
                                // height: 40,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  color: selectedSize == index
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                                child: Center(
                                    child: TextView(
                                  text:
                                      widget.productEntity?.sizes[index] ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: selectedSize == index
                                              ? Colors.white
                                              : Colors.black),
                                )),
                              ),
                            ),
                          );
                        }),
                  ),

                  ///color

                  const SizedBox(
                    height: 18,
                  ),

                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productEntity?.colors.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color:
                                          widget.productEntity?.colors[index]),
                                  child: selectedColor == index
                                      ? const Center(
                                          child: Icon(Icons.check,
                                              color: Colors.white))
                                      : const SizedBox(),
                                ),
                              ));
                        }),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Table(
                    border: TableBorder.all(color: Colors.black),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary),
                          children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextView(
                                text: "Quantity",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextView(
                                text: "Price",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            )),
                          ]),
                      ...List.generate(
                          widget.productEntity?.pricesList?.length ?? 0,
                          (index) => TableRow(
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextView(
                                      text:
                                          "${widget.productEntity?.pricesList?[index].fromQTY}-${widget.productEntity?.pricesList?[index].toQTY}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextView(
                                      text:
                                          "${widget.productEntity?.pricesList?[index].price}IQD",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                  )),
                                ],
                              )),
                    ],
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 60,
                        child: TextFormFieldView(
                          onSave: (String? content) {
                            selectedNumber = int.parse(content ?? "1");
                          },
                          textEditingController: countEditingController,
                          textFormFieldTypes: TextFormFieldTypes.text,
                          hint: "",
                          maxLines: 1,
                          errorMessage: "this_field_is_required",
                          minLength: 0,
                          maxLength: 3,
                        ),
                        // DropdownButtonFormField<int>(
                        //   value: selectedNumber,
                        //   items: List<DropdownMenuItem<int>>.generate(
                        //     200,
                        //     (index) {
                        //       return DropdownMenuItem<int>(
                        //         value: index + 1,
                        //         child: Text('${index + 1}'),
                        //       );
                        //     },
                        //   ),
                        //   onChanged: (newValue) {},
                        // ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ButtonView(
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
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
                              double finPrice = 0;

                              for (PriceModel price
                                  in widget.productEntity?.pricesList ?? []) {
                                if (int.parse(countEditingController.text) <=
                                    (price.toQTY ?? 1000000)) {
                                  finPrice = price.price ?? 0;
                                  break;
                                } else {
                                  finPrice = price.price ?? 0;
                                }
                              }

                              int count =
                                  int.parse(countEditingController.text);

                              print(
                                  "TESTT =============> count: ${count} || price: ${finPrice * count} ");

                              BlocProvider.of<CartCubit>(context).addItemToCart(
                                  cartItem: CartItemEntity(
                                      id: widget.productEntity?.id ?? 0,
                                      name: widget.productEntity?.name ?? "",
                                      image: widget.productEntity?.image ?? "",
                                      price: finPrice,
                                      count: count));
                              setState(() {
                                isProductAdded = true;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogView(
                                        content: "Product Added Successfully");
                                  });
                            },
                            title: "Add to cart",
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  TextView(
                    text: "Product Description:",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  HtmlWidget(
                      htmlContent: widget.productEntity?.description ?? ""),
                  const SizedBox(
                    height: 18,
                  ),
                  TextView(
                    text: "Shipping Details:",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  HtmlWidget(
                      htmlContent: widget.productEntity?.shippingDetails ?? ""),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return Color(
        int.parse(code.substring(1, code.length), radix: 16) + 0xFF000000);
  }
}
