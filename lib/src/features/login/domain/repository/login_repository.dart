import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../entities/login_response_entity.dart';
import '../use_cases/login_use_case.dart';

abstract class LoginRepository {
  Future<Either<ErrorModel, LoginResponseEntity>> login(
    Params? params,
  );
  Future<Either<ErrorModel, SuccessModel>> deleteAccount(

  );
  Future<Either<ErrorModel, SuccessModel>> register(
     String password, String phone,String countryCode
  );
}
