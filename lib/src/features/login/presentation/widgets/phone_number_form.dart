
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/text_form_field_view.dart';

class PhoneNumberForm extends StatelessWidget {
  final Function onCountryChanged;
  final Function onPhoneNumberSaved;
  final AutovalidateMode? autovalidateMode;
  final String? countryCode;
  final String? phoneNumber;
  final TextEditingController? textEditingController;
  final bool hasValidation;

  const PhoneNumberForm({
    Key? key,
    required this.onCountryChanged,
    required this.onPhoneNumberSaved,
    this.textEditingController,
    this.autovalidateMode,
    this.countryCode,
    this.phoneNumber,
    this.hasValidation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Flexible(
          child: TextFormFieldView(
            onSave: (String? content) {
              onPhoneNumberSaved(content ?? "");
            },
            onChanged: (String? content) {
              onPhoneNumberSaved(content ?? "");
            },
            textEditingController: textEditingController,
            textFormFieldTypes: TextFormFieldTypes.phone,
            initialValue: phoneNumber,
            errorMessage:
            (hasValidation) ? "please_enter_valid_phone_number".tr() : null,
            maxLength: 12,
            maxLines: 1,
            keyboardType: TextInputType.phone,
            hint: '765xxx',
            autovalidateMode: autovalidateMode,
          ),
        ),
      ],
    );
  }
}
