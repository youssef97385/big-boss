import 'package:bigboss/src/features/register/presentation/bloc/register_cubit.dart';
import 'package:bigboss/src/features/register/presentation/widgets/register_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => serviceLocator<RegisterCubit>(),
          child: const RegisterBody(),
        ));
  }
}
