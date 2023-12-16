import 'package:bigboss/src/features/otp-verifivation/presentation/logic/send_otp_cubit.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/logic/verify_phone_cubit.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/widgets/verify_otp_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>serviceLocator<VerifyPhoneCubit>(),),
          BlocProvider(create: (context)=>serviceLocator<SendOtpCubit>(),),
        ],
        child: VerifyOtpBody(phone:widget.phoneNumber),
      )
    );
  }
}
