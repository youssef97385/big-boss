import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

import '../../extensions/string_extension.dart';
import '../../utils/helpers/input_validation_mixin.dart';

enum TextFormFieldTypes {
  email,
  password,
  phone,
  pin,
  text,
  requiredText,
  number,
  postalCode,
  IbanNumber,
  percentage,
  TIN
}

class TextFormFieldView extends StatelessWidget with InputValidationMixin {
  final List<TextInputMask>? textInputMask;
  final TextFormFieldTypes textFormFieldTypes;
  final String? errorMessage;
  final EdgeInsets? scrollPadding;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final int? minLength;
  final bool? autofocus;
  final bool? obscureText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final void Function(String?)? onSave;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmit;
  final TextEditingController? textEditingController;
  final double? fontSize;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final bool readOnly;
  final Function()? onTap;
  final Function(String?)? validator;
  final String? labelText;

  const TextFormFieldView({
    this.textInputMask,
    required this.textFormFieldTypes,
    this.errorMessage,
    this.scrollPadding = const EdgeInsets.only(bottom: 200),
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.minLength,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.textStyle,
    this.hintStyle,
    this.autofocus = false,
    this.obscureText = false,
    required this.onSave,
    this.onChanged,
    this.onSubmit,
    this.textEditingController,
    this.fontSize,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.autovalidateMode,
    this.textCapitalization,
    this.focusNode,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      onSaved: onSave,
      onChanged: onChanged,
      autofocus: autofocus!,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      obscureText: obscureText!,
      scrollPadding: scrollPadding!,
      inputFormatters: textInputMask,
      initialValue: initialValue,
      focusNode: focusNode,
      onFieldSubmitted: onSubmit,
      controller: textEditingController,
      autovalidateMode: autovalidateMode,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        labelText: labelText,
        counterText: '',
        hintText: hint,
        hintStyle:
            Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      style: Theme.of(context).textTheme.subtitle1,
      validator: (value) {
        /// custom validator
        if (validator != null) return validator!(value);

        switch (textFormFieldTypes) {
          case TextFormFieldTypes.email:
            return isEmailValid(value ?? "") ? null : errorMessage;
          case TextFormFieldTypes.password:
            return isPasswordValid(value ?? "") ? null : errorMessage;
          case TextFormFieldTypes.phone:
            return isPhoneValid(value ?? "") ? null : errorMessage;
          case TextFormFieldTypes.requiredText:
            return isTextValid(value ?? "") ? null : errorMessage;
          case TextFormFieldTypes.pin:
            final String pin = (value ?? "").removeSpaces;
            return isPinValid(pin) ? null : errorMessage;

          case TextFormFieldTypes.number:
            return isANumber(value ?? "") ? null : errorMessage;
            if (minLength == null) {
              return null;
            } else {
              return ((value ?? "").length >= (minLength ?? 1))
                  ? null
                  : errorMessage;
            }

          case TextFormFieldTypes.postalCode:
            return isPostalCode(value ?? "") ? null : errorMessage;

          case TextFormFieldTypes.IbanNumber:
            return value?.isEmpty ?? true
                ? "This field is required"
                : isIban(value ?? "")
                    ? null
                    : errorMessage;

          case TextFormFieldTypes.percentage:
            return value?.isEmpty ?? true
                ? "This field is required"
                : isPercentage(value ?? "")
                    ? null
                    : errorMessage;

          case TextFormFieldTypes.TIN:
            return value?.isEmpty ?? true
                ? "This field is required"
                : isTinNumber(value ?? "")
                    ? null
                    : errorMessage;

          case TextFormFieldTypes.text:
            if (minLength == null) {
              return null;
            } else {
              print("vllue ${value?.length} ");
              return ((value ?? "").length > (minLength ?? 1))
                  ? null
                  : errorMessage;
            }

          default:
            return null;
        }
      },
    );
  }
}
