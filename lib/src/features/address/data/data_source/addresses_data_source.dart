import 'dart:convert';
import 'dart:developer';

import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';

abstract class AddressDataSource {
  Future<List<AddressModel>> getAddressed({required String userId});

  Future<AddressModel> getAddressById(
      {required String userId, required int addressId});

  Future<AddressModel> updateAddress(
      {required String userId,
      required int addressId,
      required Map<String, dynamic> data});

  Future<AddressModel> addAddress({required Map<String, dynamic> data});

  Future<SuccessModel> deleteAddress({
    required int addressId,
  });
}

class AddressDataSourceImpl implements AddressDataSource {
  final HttpManager httpManager;

  AddressDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<AddressModel> addAddress({required Map<String, dynamic> data}) async {
    log("ADDADDRESS $data");
    final Response response = await httpManager.request(
      path: "/UserAddresses",
      method: HttpMethods.Post,
      payload: data,
    );
    Map<String, dynamic> jsonData = json.decode(response.data);

    AddressModel model = AddressModel.fromJson(jsonData);
    return model;
  }

  @override
  Future<SuccessModel> deleteAddress({
    required int addressId,
  }) async {
    final Response response = await httpManager.request(
      path: "/UserAddresses/$addressId",
      method: HttpMethods.Delete,
    );
    Map<String, dynamic> jsonData = json.decode(response.data);

    SuccessModel model = SuccessModel.fromJson(jsonData);
    return model;
  }

  @override
  Future<AddressModel> getAddressById(
      {required String userId, required int addressId}) async {
    final Response response = await httpManager.request(
      path: "/UserAddresses/$addressId?userId=$userId",
      method: HttpMethods.Get,
    );
    Map<String, dynamic> jsonData = json.decode(response.data);



    AddressModel model = AddressModel.fromJson(jsonData);


    return model;
  }

  @override
  Future<List<AddressModel>> getAddressed({required String userId}) async {
    final Response response = await httpManager.request(
      path: "/UserAddresses?userId=$userId",
      method: HttpMethods.Get,
    );

    List<dynamic> jsonData = json.decode(response.data);

    List<AddressModel> model = jsonData
        .map((json) => AddressModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return model;
  }

  @override
  Future<AddressModel> updateAddress(
      {required String userId,
      required int addressId,
      required Map<String, dynamic> data}) {
    throw UnimplementedError();
  }
}
