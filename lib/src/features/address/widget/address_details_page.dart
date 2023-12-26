import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/alert_dialog.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/features/address/logic/add_address_cubit.dart';
import 'package:bigboss/src/features/address/logic/add_address_state.dart';
import 'package:bigboss/src/features/address/logic/address_cubit.dart';
import 'package:bigboss/src/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/common/widgets/app_bar_view.dart';
import '../../../core/common/widgets/button_view.dart';
import '../../../core/common/widgets/text_form_field_view.dart';
import '../../../core/common/widgets/text_view.dart';

class AddressDetailsPage extends StatefulWidget {
  final LatLng? latLng;

  const AddressDetailsPage({
    super.key,
    this.latLng,
  });

  @override
  State<AddressDetailsPage> createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  TextEditingController areaNameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBarView(
          appBarTitle: 'Address details'.tr(),
        ),
      ),
      body: BlocProvider(
        create: (context) => serviceLocator<AddAddressCubit>(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formGlobalKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  TextView(
                    text: "Area".tr(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextFormFieldView(
                    onSave: (String? content) {},
                    textEditingController: areaNameController,
                    textFormFieldTypes: TextFormFieldTypes.text,
                    hint: "Area".tr(),
                    maxLines: 1,
                    errorMessage: "this_field_is_required".tr(),
                    minLength: 0,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextView(
                    text: "Street_name".tr(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextFormFieldView(
                    onSave: (String? content) {},
                    textEditingController: streetController,
                    textFormFieldTypes: TextFormFieldTypes.text,
                    hint: "Street_name".tr(),
                    maxLines: 1,
                    errorMessage: "this_field_is_required".tr(),
                    minLength: 0,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextView(
                    text: "Building_name_number".tr(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextFormFieldView(
                    onSave: (String? content) {},
                    textEditingController: buildingController,
                    textFormFieldTypes: TextFormFieldTypes.text,
                    hint: "Building_name_number".tr(),
                    maxLines: 1,
                    errorMessage: "this_field_is_required".tr(),
                    minLength: 0,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  BlocConsumer<AddAddressCubit, AddAddressState>(
                      listener: (context, state) {
                    state.maybeWhen(
                        orElse: () {},
                        success: () {
                          BlocProvider.of<AddressCubit>(context).getAddress();
                          context.router.pop();
                        },
                        error: (String e) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialogView(content: e);
                              });
                        });
                  }, builder: (context, state) {
                    return state.maybeWhen(orElse: () {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: SizedBox(
                            width: 280,
                            height: 65,
                            child: ButtonView(
                              title: "Add".tr(),
                              buttonType: ButtonType.soldButton,
                              onClick: () {
                                Map<String, dynamic> addressData = {
                                  "street_address": "${streetController.text}",
                                  "area": "${areaNameController.text}",
                                  "building": "${buildingController.text}"
                                };

                                String stringAddressData =
                                    jsonEncode(addressData);

                                if (_formGlobalKey.currentState!.validate()) {
                                  _formGlobalKey.currentState?.save();
                                  BlocProvider.of<AddAddressCubit>(context)
                                      .addAddress({
                                    "attitude": "${widget.latLng?.longitude}",
                                    "latitude": "${widget.latLng?.latitude}",
                                    "remark": stringAddressData
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }, loading: () {
                      return LoadingView();
                    });
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
