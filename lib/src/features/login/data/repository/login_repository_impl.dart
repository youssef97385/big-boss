import 'dart:developer';
import 'dart:io' show Platform;
import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/login/data/models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../app/logic/app_settings.dart';
import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/utils/helpers/error_parser.dart';
import '../../../../core/utils/managers/notification/gms_notification_manager.dart';
import '../../../../injection.dart';
import '../../domain/entities/login_response_entity.dart';
import '../../domain/repository/login_repository.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../data_source/remote_data_source/login_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource loginDataSource;
  final GmsNotificationsManager gmsNotificationsManager;

  LoginRepositoryImpl({
    required this.loginDataSource,
    required this.gmsNotificationsManager,
  });

  @override
  Future<Either<ErrorModel, LoginResponseEntity>> login(
    Params? params,
  ) async {
    try {
      await gmsNotificationsManager.init();

      await Future.delayed(const Duration(seconds: 1));

      String? token = await gmsNotificationsManager.getToken();

      log("Token firebasse $token");
      String platform = "ios";
      if (Platform.isAndroid) {
        platform = "android";
      }
      Map<String, dynamic>? parms = params?.value;

      parms?.addAll({
        "token": token,
        "device": platform //web, android or ios
      });

      final response = await loginDataSource.login(parms ?? {});

      final LoginModel loginModel = LoginModel.fromJson(response);

      serviceLocator<AppSettings>().token = loginModel.token;
      serviceLocator<DatabaseManager>().saveData("USERID", loginModel.userId);
      serviceLocator<DatabaseManager>()
          .saveData("ISPHONECONFIRMED", loginModel.isPhoneNumberConfirmed);

      serviceLocator<DatabaseManager>()
          .saveData("USERNAME", params?.value["username"]);

      return Right(LoginResponseEntity(
          phone: loginModel.phone,
          isVerified: loginModel.isPhoneNumberConfirmed ?? false));
    } on DioError catch (error, stackTrace) {
      print("ERROR DDD $error");
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, SuccessModel>> register(
     String password, String phone,String countryCode) async {
    try {
      var data = {
        "username":"$countryCode$phone",
        "password": password,
        "phone": "$countryCode$phone"
      };
      final response = await loginDataSource.register(data);

      final LoginModel loginModel = LoginModel.fromJson(response);

      serviceLocator<DatabaseManager>().saveData("USERID", loginModel.userId);
      serviceLocator<DatabaseManager>().saveData("ISPHONECONFIRMED", false);

      await gmsNotificationsManager.init();

      await Future.delayed(const Duration(seconds: 1));

      String? token = await gmsNotificationsManager.getToken();

      log("Token firebasse $token");
      String platform = "ios";
      if (Platform.isAndroid) {
        platform = "android";
      }
      Map<String, dynamic>? parms = {
        'username': "$countryCode$phone",
        'password': password,
        "token": token,
        "device": platform
      };

      final vResponse = await loginDataSource.login(parms);

      final LoginModel loginModel2 = LoginModel.fromJson(vResponse);

      serviceLocator<AppSettings>().token = loginModel2.token;
      serviceLocator<DatabaseManager>().saveData("USERNAME", "$countryCode$phone");
      return Right(SuccessModel());
    } on DioError catch (error, stackTrace) {
      print("ERROR DDD $error");
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, SuccessModel>> deleteAccount() async {
    try {
      final response = await loginDataSource.deleteAccount();
      return Right(SuccessModel());
    } on DioError catch (error, stackTrace) {
      print("ERROR DDD $error");
      return Left(errorParse(error, stackTrace));
    }
  }
}
