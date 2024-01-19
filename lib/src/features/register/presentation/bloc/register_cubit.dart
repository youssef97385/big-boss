import 'package:bigboss/src/features/login/domain/repository/login_repository.dart';
import 'package:bigboss/src/features/register/presentation/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final LoginRepository loginRepository;

  RegisterCubit({required this.loginRepository})
      : super(const RegisterState.initial());

  Future<void> register(
       String password, String phone,String countryCode) async {
    emit(const RegisterState.loading());
    final userIssues =
        await loginRepository.register(  password, phone,countryCode);
    emit(
      userIssues.fold((ErrorModel error) {
        return RegisterState.error(errorModel: error);
      }, (_) {
        return const RegisterState.successLogin();
      }),
    );
  }
}
