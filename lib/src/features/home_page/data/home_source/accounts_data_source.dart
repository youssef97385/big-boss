import 'dart:convert';

import 'package:bigboss/src/core/common/data/models/generic_model/generic_model.dart';
import 'package:bigboss/src/features/home_page/data/models/slide_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';

abstract class AccountsDataSource {
  Future<List<GenericModel>?> getAccounts();
}

class AccountsDataSourceImpl implements AccountsDataSource {
  final HttpManager httpManager;

  AccountsDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<List<GenericModel>?> getAccounts() async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/EAccounts",
      method: HttpMethods.Get,
    );
    List<dynamic> jsonData = json.decode(response.data);

    List<GenericModel> model = jsonData.map((json) => GenericModel.fromJson(json as Map<String, dynamic>)).toList();
    return model;
  }
}
