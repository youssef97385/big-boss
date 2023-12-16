import 'package:bigboss/src/features/otp-verifivation/data/repository/send_otp_repository.dart';
import 'package:bigboss/src/features/otp-verifivation/presentation/logic/send_otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';


class SendOtpCubit extends Cubit<SendOtpState> {
  final SendOtpRepository repository;

  SendOtpCubit({required this.repository})
      :
        super(const SendOtpState.initial());

  Future<void> sendOtp(String phone) async {
    emit(const SendOtpState.loading());
    String phoneNumber = phone.contains("+")?phone:"+964$phone";
    final result = await repository.sendOtp(phoneNumber);
    emit(
      result.fold((ErrorModel error) {

        return SendOtpState.error(errorModel: error);
      }, (model) {
        return SendOtpState.success(model);
      }),
    );
  }
}
