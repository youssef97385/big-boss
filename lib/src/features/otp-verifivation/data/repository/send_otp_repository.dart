import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/otp-verifivation/data/data_source/send_otp_data_source.dart';
import 'package:bigboss/src/features/otp-verifivation/data/models/send_otp_response_model.dart';
import 'package:bigboss/src/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/utils/helpers/error_parser.dart';

abstract class SendOtpRepository {
  Future<Either<ErrorModel, SendOtpResponseModel>> sendOtp(String phone);

  Future<Either<ErrorModel, SuccessModel>> verifyPhone();
}

class SendOtpRepositoryImpl implements SendOtpRepository {
  final SendOtpDataSource sendOtpDataSource;
  final DatabaseManager databaseManager;

  SendOtpRepositoryImpl(
      {required this.sendOtpDataSource, required this.databaseManager,});

  @override
  Future<Either<ErrorModel, SendOtpResponseModel>> sendOtp(String phone) async {
    try {
      final response = await sendOtpDataSource.sendOtp(phone);

      SendOtpResponseModel sendOtpResponseModel =
      SendOtpResponseModel.fromJson(response);

      return Right(sendOtpResponseModel);
    } on DioError catch (error, stackTrace) {
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, SuccessModel>> verifyPhone() async {
    try {
      final String? userId =databaseManager.getData("USERID");

      final response = await sendOtpDataSource.verifyPhone(userId??"");

      SuccessModel successModel =
      SuccessModel.fromJson(response);

      return Right(successModel);
    } on DioError catch (error, stackTrace) {
      return Left(errorParse(error, stackTrace));
    }
  }
}
