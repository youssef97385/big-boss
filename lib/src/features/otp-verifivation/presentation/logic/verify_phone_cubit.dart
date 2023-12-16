import 'package:bigboss/src/features/otp-verifivation/data/repository/send_otp_repository.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/logic/send_otp_state.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/logic/verify_phone_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';


class VerifyPhoneCubit extends Cubit<VerifyPhoneState> {
  final SendOtpRepository repository;

  VerifyPhoneCubit({required this.repository})
      :
        super(const VerifyPhoneState.initial());

  Future<void> verifyPhone() async {
    emit(const VerifyPhoneState.loading());
    final result = await repository.verifyPhone();
    emit(
      result.fold((ErrorModel error) {

        return VerifyPhoneState.error(errorModel: error);
      }, (model) {
        return const VerifyPhoneState.success();
      }),
    );
  }
}
