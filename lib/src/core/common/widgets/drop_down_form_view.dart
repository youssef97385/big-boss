import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/const.dart';
import 'text_view.dart';

class DropDownFormView<T> extends StatelessWidget {
  final String? errorMessage;
  final List<T?>? options;
  final bool isDense;
  T? value;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final String Function(T?) getLabel;

  DropDownFormView({
    required this.options,
    required this.getLabel,
    required this.onChanged,
    required this.onSaved,
    this.errorMessage,
    this.value,
    this.isDense = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(

      decoration: InputDecoration(hintText: "Choose_here".tr()),
      isExpanded: true,
      value: value,
      onSaved: onSaved,
      validator: (value) => value == null ? errorMessage : null,
      style: Theme.of(context).textTheme.subtitle1,
      items: options?.map<DropdownMenuItem<T>>((T? value) {
        return DropdownMenuItem<T>(
          value: value,
          child: TextView(
            overflow: TextOverflow.visible,
            text: getLabel(value),
            maxLines: 2,
            style: Theme.of(context).textTheme.headline3,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        onChanged!(newValue);
      },
    );
  }
}
