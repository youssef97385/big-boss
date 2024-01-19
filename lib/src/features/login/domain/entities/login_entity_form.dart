import 'package:equatable/equatable.dart';

class LoginFormEntity extends Equatable {
  String? userName;
  String? password;


  LoginFormEntity({
    this.userName,
    this.password,
  });

  @override
  List<Object?> get props => [
        userName,
        password,
      ];
}
