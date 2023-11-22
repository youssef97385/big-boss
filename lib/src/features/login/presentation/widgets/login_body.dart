import 'package:bigboss/src/features/login/presentation/widgets/password_field.dart';
import 'package:bigboss/src/features/login/presentation/widgets/phone_number_form.dart';
import 'package:auto_route/auto_route.dart';

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
import '../../../../core/constants/image_name.dart';
import '../../../../injection.dart';
import '../../domain/entities/login_entity_form.dart';
import '../logic/login_cubit.dart';
import '../logic/login_state.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();
  LoginFormEntity? loginFormEntity = LoginFormEntity();
  AutovalidateMode? autovalidateMode;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            error: (ErrorModel errorModel) {
              showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.6),
                  builder: (_) {
                    return AlertDialogView(
                      content: errorModel.error ?? '',
                    );
                  });

              // }
            },
            successLogin: () {
              context.router.replaceNamed("main");
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
                        text: "user name".tr(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormFieldView(
                        onSave: (String? content) {
                          loginFormEntity?.userName = content;
                        },
                        textEditingController: userNameController,
                        textFormFieldTypes: TextFormFieldTypes.text,
                        hint: "User name",
                        maxLines: 1,
                        errorMessage: "this_field_is_required".tr(),
                        minLength: 0,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PasswordField(
                        title: "Password".tr(),
                        hint: "Your_password".tr(),
                        controller: passwordController,
                        onSaved: (content) {
                          loginFormEntity?.password = content ?? "";
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
                              title: "Login".tr(),
                              buttonType: ButtonType.soldButton,
                              onClick: () {
                                if (_formGlobalKey.currentState!.validate()) {
                                  _formGlobalKey.currentState?.save();
                                  BlocProvider.of<LoginCubit>(context).doLogin(
                                      loginFormEntity ?? LoginFormEntity());
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
                      const SizedBox(height: 10,),

                      Row(children: [
                        TextView(text: "Don't have an accont yet",style: Theme.of(context).textTheme.bodyLarge,),
                        ButtonView(buttonType: ButtonType.textButton, onClick: (){
                          context.router.push(RegisterPageAppRouter());

                        },title: "Create account",)
                      ],)
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => Center(child: LoadingView()),
          successLogin: () => Center(child: LoadingView())),
    ));
  }
}
