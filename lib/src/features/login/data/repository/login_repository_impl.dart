import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/login/data/models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../app/logic/app_settings.dart';
import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/utils/helpers/error_parser.dart';
import '../../../../injection.dart';
import '../../domain/repository/login_repository.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../data_source/remote_data_source/login_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource loginDataSource;

  LoginRepositoryImpl({
    required this.loginDataSource,
  });

  @override
  Future<Either<ErrorModel, SuccessModel>> login(
    Params? params,
  ) async {
    try {
      final response = await loginDataSource.login(params?.value ?? {});

      final LoginModel loginModel = LoginModel.fromJson(response);

      serviceLocator<AppSettings>().token = loginModel.token;
      serviceLocator<DatabaseManager>().saveData("USERID", loginModel.userId);
      serviceLocator<DatabaseManager>()
          .saveData("ISPHONECONFIRMED", loginModel.isPhoneNumberConfirmed);

      return Right(SuccessModel());
    } on DioError catch (error, stackTrace) {
      print("ERROR DDD $error");
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, SuccessModel>> register(
      String userName, String email, String password, String phone) async {
    try {
      var data = {
        "username": userName,
        "email": email,
        "password": password,
        "phone": "+964$phone"
      };
      final response = await loginDataSource.register(data);

      final LoginModel loginModel = LoginModel.fromJson(response);

      serviceLocator<DatabaseManager>().saveData("USERID", loginModel.userId);
      serviceLocator<DatabaseManager>().saveData("ISPHONECONFIRMED", false);

      final vResponse = await loginDataSource.login({
        'username': userName,
        'password': password
      });

      final LoginModel loginModel2 = LoginModel.fromJson(vResponse);

      serviceLocator<AppSettings>().token = loginModel2.token;

      return Right(SuccessModel());
    } on DioError catch (error, stackTrace) {
      print("ERROR DDD $error");
      return Left(errorParse(error, stackTrace));
    }
  }
}
