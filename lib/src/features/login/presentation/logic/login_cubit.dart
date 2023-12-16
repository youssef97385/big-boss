import 'package:bigboss/src/features/login/domain/entities/login_response_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../domain/entities/login_entity_form.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login _login;

  LoginCubit({required Login login})
      : _login = login,
        super(const LoginState.initial());

  Future<void> doLogin(LoginFormEntity loginFormEntity) async {
    emit(const LoginState.loading());
    final userIssues = await _login(Params(entity: loginFormEntity));
    emit(
      userIssues.fold((ErrorModel error) {
        return LoginState.error(errorModel: error);
      }, (LoginResponseEntity loginResponseEntity) {
        return LoginState.successLogin(loginResponseEntity.phone ?? "",
            loginResponseEntity.isVerified ?? false);
      }),
    );
  }
}
