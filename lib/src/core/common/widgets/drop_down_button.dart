import 'package:flutter/material.dart';

import '../../../injection.dart';

import 'text_view.dart';

class DropDownButton<T> extends StatefulWidget {
  final List<T?>? options;
  T? value;
  final void Function(T?)? onChanged;
  final String Function(T?) getLabel;
  final String? semanticLabelValue;
  final Color? textColor;

  DropDownButton({
    required this.options,
    required this.getLabel,
    required this.onChanged,
    this.semanticLabelValue,
    this.value,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  _DropDownButtonState<T> createState() => _DropDownButtonState<T>();
}

class _DropDownButtonState<T> extends State<DropDownButton<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () {

        },
        alignment: Alignment.centerLeft,
        value: widget.value,
        items: widget.options?.map<DropdownMenuItem<T>>((T? value) {
          return DropdownMenuItem<T>(
            value: value,
            child: TextView(
              text: widget.getLabel(value),
              style: TextStyle(
                color: widget.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            widget.value = newValue;
          });

          widget.onChanged!(newValue);
        },
      ),
    );
  }
}
