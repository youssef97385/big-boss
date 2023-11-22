import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum ReachabilityStatus { reachable, unreachable }

abstract class CheckEndpointReachability {
  Future<ReachabilityStatus> check(String endpoint);
}

class CheckEndpointReachabilityImpl implements CheckEndpointReachability {
  late final Dio _dio;

  CheckEndpointReachabilityImpl() {
    _dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "charset": "utf-8",
          "Accept-Charset": "utf-8",
          'Accept-Language': 'en',
          'X-Channel': 'mobile'
        },
        responseType: ResponseType.plain,
        receiveDataWhenStatusError: true,
        connectTimeout: 15 * 1000, // 10 seconds
        receiveTimeout: 15 * 1000, // 10 seconds
        sendTimeout: 15 * 1000, // 10 seconds
      ),
    );
  }

  @override
  Future<ReachabilityStatus> check(String endpoint) async {
    try {
      await _dio.get(endpoint);

      debugPrint("You are connected to $endpoint");
      return ReachabilityStatus.reachable;
    } catch (_) {
      debugPrint("You are not connected to $endpoint");
      return ReachabilityStatus.unreachable;
    }
  }
}
