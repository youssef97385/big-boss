import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/common/widgets/alert_dialog.dart';
import 'package:bigboss/src/core/common/widgets/error_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/features/otp-verifivation/data/models/send_otp_response_model.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/logic/send_otp_cubit.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/logic/send_otp_state.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/logic/verify_phone_cubit.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/logic/verify_phone_state.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/widgets/pincode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import '../../../../core/common/widgets/button_view.dart';
import '../../../../core/common/widgets/text_view.dart';
import '../../../../core/constants/const.dart';

class VerifyOtpBody extends StatefulWidget {
  final String phone;

  const VerifyOtpBody({
    super.key,
    required this.phone,
  });

  @override
  State<VerifyOtpBody> createState() => _VerifyOtpBodyState();
}

class _VerifyOtpBodyState extends State<VerifyOtpBody> {
  TextEditingController otpCodeTextEditingController = TextEditingController();

  bool isPinCodeValid = false;
  bool verifyButtonValid = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SendOtpCubit>(context).sendOtp(widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendOtpCubit, SendOtpState>(builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return const SizedBox();
      }, loading: () {
        return Center(child: LoadingView());
      }, error: (ErrorModel errorModel) {
        return Center(
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
                  text: "Error_sending_OTP".tr(),
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
                title: "Try_again".tr(),
                onClick: () {
                  BlocProvider.of<SendOtpCubit>(context).sendOtp(widget.phone);
                },
                icon: Icons.refresh,
              ),
            ],
          ),
        );
      }, success: (SendOtpResponseModel sendOtpResponseModel) {
        RegExp regExp = RegExp(
            r'\d+'); // This regular expression matches one or more digits
        String matchedNumber = "";
        Match? match = regExp.firstMatch(sendOtpResponseModel.message ?? "");

        if (match != null) {
          matchedNumber = match.group(0) ?? "";
          log("$matchedNumber");
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100),
                Center(
                    child: Image.asset(
                  "assets/images/big-boss-splash-logo.png",
                  height: 150,
                  width: 150,
                )),
                const SizedBox(
                  height: 24,
                ),
                TextView(
                  text: 'Verification_code'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 27),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TextView(
                      text: "We_have_send_code_to".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 20, height: 1.5),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: TextView(
                        text: context.locale.languageCode == kEn
                            ? "${widget.phone}."
                            : "${widget.phone}",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 20, height: 1.5),
                      ),
                    ),
                  ],
                ),

                TextView(
                  text: 'enter_the_code_below'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 20, height: 1.5),
                ),
                const SizedBox(
                  height: 40,
                ),
                PinCodeWidget(
                  textEditingController: otpCodeTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      if (((value?.length ?? 0) == 6)) {
                        setState(() {
                          verifyButtonValid = true;
                        });
                      } else {
                        setState(() {
                          verifyButtonValid = false;
                        });
                      }
                    });
                  },
                  onCompleted: () {},
                  pinCodeValidator: (v) {
                    if (v!.length < 6) {
                      isPinCodeValid = false;
                    } else {
                      isPinCodeValid = true;
                      if (matchedNumber == otpCodeTextEditingController.text) {
                        BlocProvider.of<VerifyPhoneCubit>(context)
                            .verifyPhone();
                      } else {
                        otpCodeTextEditingController.clear();
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialogView(
                                  content:
                                      "Pin_code_is_incorrect_try_again".tr());
                            });
                      }
                      BlocProvider.of<VerifyPhoneCubit>(context).verifyPhone();
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<VerifyPhoneCubit, VerifyPhoneState>(
                    listener: (context, state) {
                  state.maybeWhen(
                      orElse: () {},
                      success: () {
                        context.router.navigateNamed("main");
                      });
                }, builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ButtonView(
                        isDisabled: !verifyButtonValid,
                        title: "Verify".tr(),
                        buttonType: ButtonType.soldButton,
                        onClick: () async {
                          if (isPinCodeValid) {
                            if (matchedNumber ==
                                otpCodeTextEditingController.text) {
                              BlocProvider.of<VerifyPhoneCubit>(context)
                                  .verifyPhone();
                            } else {
                              otpCodeTextEditingController.clear();
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialogView(
                                        content:
                                            "Pin_code_is_incorrect_try_again"
                                                .tr());
                                  });
                            }
                          }
                        },
                      ),
                    );
                  }, loading: () {
                    return LoadingView();
                  });
                }),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Center(
                      child: TextView(
                          text: 'have_not_receive_code'.tr(),
                          style: Theme.of(context).textTheme.displaySmall),
                    ),
                    ButtonView(
                        title: "Send_again".tr(),
                        buttonType: ButtonType.textButton,
                        onClick: () {
                          BlocProvider.of<SendOtpCubit>(context)
                              .sendOtp(widget.phone);
                        }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // enableResend
              ],
            ),
          ),
        );
      });
    });
  }
}
