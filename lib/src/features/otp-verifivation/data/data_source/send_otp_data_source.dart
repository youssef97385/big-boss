import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';

abstract class SendOtpDataSource {
  Future<Map<String, dynamic>> sendOtp(String phone);
  Future<Map<String, dynamic>> verifyPhone(String userId);
}

class SendOtpDataSourceImpl implements SendOtpDataSource {
  final HttpManager httpManager;

  SendOtpDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final Response response = await httpManager.request(
      path: "/Authenticate/SendOTP?phoneNumber=$phone",
      method: HttpMethods.Post,
    );
    return json.decode(response.data as String) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> verifyPhone(String userId) async {
    final Response response = await httpManager.request(
      path: "/Authenticate/VerifyPhoneNumber?userId=$userId",
      method: HttpMethods.Post,
    );
    return json.decode(response.data as String) as Map<String, dynamic>;
  }
}
