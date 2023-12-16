import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  String? phone;
  bool? isVerified;

  LoginResponseEntity({
    this.phone,
    this.isVerified,
  });

  @override
  List<Object?> get props => [
    phone,
  ];
}
