import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../../core/utils/managers/http/http_manager.dart';
import '../../../../../core/utils/managers/http/http_methods.dart';

abstract class LoginDataSource {
  Future<Map<String, dynamic>> login(Map<String, dynamic> data);
  Future<Map<String, dynamic>> register(Map<String, dynamic> data);
  Future<Map<String, dynamic>> verifyPhoneNumber(String userID );
  Future<Map<String, dynamic>> deleteAccount( );
}

class LoginDataSourceImpl implements LoginDataSource {
  final HttpManager httpManager;

  LoginDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {

    log("login params ${data}");

    final Response response = await httpManager.request(
      path: "/Authenticate/login",
      method: HttpMethods.Post,
      payload: data,
    );
    return json.decode(response.data as String) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {

    log("register data $data");
    final Response response = await httpManager.request(
      path: "/Authenticate/register",
      method: HttpMethods.Post,
      payload: data,
    );
    return json.decode(response.data as String) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> verifyPhoneNumber(String userID) async {
    final Response response = await httpManager.request(
      path: "/Authenticate/VerifyPhoneNumber?userId=$userID",
      method: HttpMethods.Post,
    );
    return json.decode(response.data as String) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> deleteAccount() async {
    final Response response = await httpManager.request(
      path: "/Authenticate/DeleteAccount",
      method: HttpMethods.Post,
    );
    return json.decode(response.data as String) as Map<String, dynamic>;
  }
}
