import 'dart:io';

import 'package:flutter/material.dart';

abstract class DomainLookup {
  Future<bool> check(String domain);
}

class DomainLookupImpl implements DomainLookup {
  @override
  Future<bool> check(String domain) async {
    try {
      final result = await InternetAddress.lookup(domain);

      final String? ipAddress = result[0].address;

      if (ipAddress == null) return false;

      final bool isDomainReachable =
          await checkTCPConnection(ipAddress: ipAddress);
      return isDomainReachable;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<bool> checkTCPConnection({
    required String ipAddress,
    int port = 80,
  }) async {
    debugPrint('Socket connecting');
    try {
      final Socket socket = await Socket.connect(ipAddress, port,
          timeout: const Duration(seconds: 5));
      debugPrint('Socket connected');
      socket.close();
      return true;
    } on SocketException {
      debugPrint('Socket not connected');
      return false;
    }
  }
}
