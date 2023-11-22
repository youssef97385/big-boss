import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/common/data/models/success_model/success_model.dart';
import '../entities/login_entity_form.dart';
import '../repository/login_repository.dart';

class Login {
  Login({required this.repository});

  final LoginRepository repository;

  @override
  Future<Either<ErrorModel, SuccessModel>> call(
    Params? params,
  ) {
    return repository.login(params);
  }
}

class Params extends Equatable {
  late final Map<String, dynamic> value;

  Params({required LoginFormEntity entity}) {
    value = {
      'username': entity.userName,
      'password': entity.password
    };
  }

  @override
  List<Object> get props => [value];
}
