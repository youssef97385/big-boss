import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/constants/const.dart';

class PinCodeWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function onChanged;
  final Function onCompleted;
  final Function pinCodeValidator;

  const PinCodeWidget({
    Key? key,
    required this.textEditingController,
    required this.onChanged,
    required this.onCompleted,
    required this.pinCodeValidator,
  }) : super(key: key);

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  bool isPinCodeValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Pinput(
                errorPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 20),
                  decoration: BoxDecoration(

                    border: Border.all(
                        color: Theme.of(context).colorScheme.error),
                  ),
                ),
                errorText: "Wrong Pin",
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                obscureText: false,
                pinContentAlignment: Alignment.center,
                toolbarEnabled: true,
                keyboardType: TextInputType.number,
                length: 6,
                controller: widget.textEditingController,
                androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsRetrieverApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 20),
                  decoration: BoxDecoration(

                    border: Border.all(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),

                pinAnimationType: PinAnimationType.fade,
                validator: (v) {
                  return widget.pinCodeValidator(v);
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {},
                onChanged: (value) {
                  widget.onChanged(value);
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 2,
                      height: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}