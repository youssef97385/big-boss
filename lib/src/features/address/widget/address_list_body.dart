import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/alert_dialog.dart';
import 'package:bigboss/src/core/common/widgets/error_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:bigboss/src/features/address/logic/address_cubit.dart';
import 'package:bigboss/src/features/address/logic/address_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/widgets/button_view.dart';
import '../../../injection.dart';

class AddressListBody extends StatefulWidget {
  const AddressListBody({super.key});

  @override
  State<AddressListBody> createState() => _AddressListBodyState();
}

class _AddressListBodyState extends State<AddressListBody> {
  int addressChosenIndex = -1;
  AddressModel? addressModel;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressCubit>(context).getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressSatate>(builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return SizedBox();
      }, loading: () {
        return Center(child: LoadingView());
      }, deleting: () {
        return Center(child: LoadingView());
      }, error: (String message) {
        return ErrorView(
            error: message,
            onRefresh: () {
              BlocProvider.of<AddressCubit>(context).getAddress();
            });
      }, success: (List<AddressModel> addresses) {
        return Visibility(
          visible: addresses.isNotEmpty,
          replacement: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error,
                  size: 120,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 18.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextView(
                    text: "You_don't_have_any_addresses_add_now".tr(),
                    textAlignment: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(height: 1.6),
                  ),
                ),
                const SizedBox(height: 21.0),
                ButtonView(
                  buttonType: ButtonType.soldButton,
                  title: "Add_address".tr(),
                  onClick: () {
                    context.router.push(MapPickerAppRouter());

                    BlocProvider.of<AddressCubit>(context).getAddress();
                  },
                  icon: Icons.add,
                ),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextView(
                    text: "Please_choose_address".tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ListView.builder(
                    itemCount: addresses.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> addressRemark =
                          json.decode(addresses[index].remark ?? "");
                      return InkWell(
                        onTap: () {
                          setState(() {
                            addressChosenIndex = index;
                            addressModel = addresses[index];
                          });
                        },
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: ButtonView(
                                  icon: Icons.remove_circle,
                                  iconColor: Colors.red,
                                  buttonType: ButtonType.textButton,
                                  title: "remove".tr(),
                                  textColor: Colors.red,
                                  onClick: () {
                                    BlocProvider.of<AddressCubit>(context)
                                        .deleteAddress(addresses[index].id);
                                  },
                                ),
                              ),
                              Visibility(
                                visible: index == addressChosenIndex,
                                child: Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.check_box,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.my_location,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      TextView(
                                        text: "${addressRemark["area"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      TextView(
                                        text:
                                            "${addressRemark["street_address"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_city,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      TextView(
                                        text: "${addressRemark["building"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                      );
                    }),
                const SizedBox(
                  height: 18,
                ),
                ButtonView(
                  buttonType: ButtonType.soldButton,
                  onClick: () async {
                    final value =
                        await context.router.push(MapPickerAppRouter());
                  },
                  title: "Add_new_address".tr(),
                  icon: Icons.add,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 250,
                    child: ButtonView(
                      buttonStyle: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Theme.of(context).colorScheme.primary),
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.white),
                      ),
                      buttonType: ButtonType.soldButton,
                      onClick: () async {
                        if (addressModel != null) {
                          context.router.replace(OrderSummaryAppRouter(
                              addressModel: addressModel!));
                        }else{
                          showDialog(context: context, builder: (context){
                            return AlertDialogView(content: "Please_choose_address_first".tr());
                          });
                        }
                      },
                      title: "Continue".tr(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
