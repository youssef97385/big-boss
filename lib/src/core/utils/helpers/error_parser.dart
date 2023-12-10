import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../injection.dart';
import '../../common/data/models/error_model/error_model.dart';

ErrorModel errorParse(error, stackTrace) {
  if (error is DioError) {
    print("ERRRR ${error.response}");
    final int statusCode = error.response?.statusCode ?? 500;
    if (statusCode == 500) {
      final Error localError = Error(message: "Error_Communication".tr());
      final ErrorModel localErrorData = ErrorModel(error: "Error_Communication".tr());
      return localErrorData;
    } else {

      try {
        final Map<String, dynamic> errorResponse =
        json.decode(error.response?.data as String? ?? "{}")
        as Map<String, dynamic>;
        final ErrorModel backendErrorData = ErrorModel.fromJson(errorResponse);

        return backendErrorData;
      } catch (error) {
        debugPrint(error.toString());
        final Error localError = Error(message: "Error_Communication".tr());
        final ErrorModel localErrorData = ErrorModel(error: "Error_Communication".tr());

        return localErrorData;
      }
    }
  } else {
    final Error localError = Error(message: "Error_Communication".tr());
    final ErrorModel localErrorData = ErrorModel(error: "Error_Communication".tr());
    return localErrorData;
  }
}
