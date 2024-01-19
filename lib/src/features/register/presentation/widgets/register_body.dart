import 'package:bigboss/src/features/login/presentation/widgets/password_field.dart';
import 'package:bigboss/src/features/login/presentation/widgets/phone_number_form.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/features/register/presentation/bloc/register_cubit.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/routes/router.dart';
import '../../../../app/routes/router.gr.dart';
import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/common/widgets/alert_dialog.dart';
import '../../../../core/common/widgets/button_view.dart';
import '../../../../core/common/widgets/loading_view.dart';
import '../../../../core/common/widgets/text_form_field_view.dart';
import '../../../../core/common/widgets/text_view.dart';
import '../bloc/register_state.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  AutovalidateMode? autovalidateMode;

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String phone = "";
  String password = "";
  String countryCode = "+964";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                error: (ErrorModel errorModel) {
                  showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.6),
                      builder: (_) {
                        return AlertDialogView(
                          content: errorModel.message ?? '',
                        );
                      });

                  // }
                },
                successLogin: () {
                  context.router.navigate(VerifyOtpScreenAppRouter(phoneNumber: phoneController.text));
                });
          },
          builder: (context, state) => state.maybeWhen(
              orElse: () {
                return Form(
                  key: _formGlobalKey,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Center(
                            child: SizedBox(
                              width: 240,
                              child: Image.asset(
                                'assets/images/big-boss-splash-logo.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),





                          TextView(
                            text: "phone".tr(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),

                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 130,
                                child: CountryCodePicker(
                                  onChanged: (CountryCode? code) {
                                    setState(() {
                                      countryCode = code?.dialCode ?? "+964";
                                    });
                                  },
                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  initialSelection: 'IQ',
                                  favorite: ['+964', 'IQ'],
                                  // optional. Shows only country name and flag
                                  showCountryOnly: false,
                                  // optional. Shows only country name and flag when popup is closed.
                                  showOnlyCountryWhenClosed: false,
                                  // optional. aligns the flag and the Text left
                                  alignLeft: false,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(width: 290,
                                child: TextFormFieldView(
                                  onSave: (String? content) {
                                    phone = content ??"";
                                  },
                                  textEditingController: phoneController,
                                  textFormFieldTypes: TextFormFieldTypes.phone,
                                  hint: "",
                                  keyboardType: TextInputType.number,
                                  errorMessage: "please_provide_valid_phone".tr(),

                                ),
                              ),
                            ],
                          ),


                          const SizedBox(
                            height: 20,
                          ),
                          PasswordField(
                            title: "Password".tr(),
                            hint: "Your_password".tr(),
                            controller: passwordController,
                            onSaved: (content) {
                              password = content ?? "";
                            },
                            autovalidateMode: autovalidateMode,
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: SizedBox(
                                width: 280,
                                height: 65,
                                child: ButtonView(
                                  title: "Register".tr(),
                                  buttonType: ButtonType.soldButton,
                                  onClick: () {
                                    if (_formGlobalKey.currentState!.validate()) {
                                      _formGlobalKey.currentState?.save();
                                      BlocProvider.of<RegisterCubit>(context).register(
                                          password,phone,countryCode);
                                    } else {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.onUserInteraction;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              loading: () => Center(child: LoadingView()),
              ),
        ));
  }
}
