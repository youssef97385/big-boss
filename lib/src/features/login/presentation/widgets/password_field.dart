import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/text_form_field_view.dart';
import '../../../../core/common/widgets/text_view.dart';


class PasswordField extends StatefulWidget {
  final String title;
  final String hint;
  final Function onSaved;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;
  final int? maxLength;
  final Function(String?)? validator;

  const PasswordField({
    Key? key,
    required this.title,
    required this.hint,
    required this.onSaved,
    this.autovalidateMode,
    this.controller,
    this.focusNode,
    this.onSubmit,
    this.maxLength,
    this.validator,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: widget.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormFieldView(
          onSave: (String? content) {
            widget.onSaved(content);
          },
          onSubmit: (value) {
            if (widget.onSubmit != null) widget.onSubmit!(value!);
          },
          textEditingController: widget.controller,
          textFormFieldTypes: TextFormFieldTypes.password,
          hint: widget.hint,
          obscureText: !_passwordVisible,
          maxLines: 1,
          maxLength: widget.maxLength,
          errorMessage: "password_is_required".tr(),
          focusNode: widget.focusNode,
          validator: (value) {
            /// custom validator
            if (widget.validator != null) return widget.validator!(value);
            return (value != null && value.length > 5)
                ? null
                : "password_is_required".tr();
          },
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          autovalidateMode: widget.autovalidateMode,
        ),
      ],
    );
  }
}
