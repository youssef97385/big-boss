import 'dart:convert';
import 'dart:developer';

import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/utils/helpers/error_parser.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/address/data/data_source/addresses_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/common/data/models/success_model/success_model.dart';
import '../models/address_model.dart';

abstract class AddressRepository {
  Future<Either<ErrorModel, List<AddressModel>>> getAddresses();

  Future<Either<ErrorModel, AddressModel>> getAddressById(
      {required int addressId});

  Future<Either<ErrorModel, AddressModel>> updateAddress(
      {required int addressId, required Map<String, dynamic> data});

  Future<Either<ErrorModel, AddressModel>> addAddress(
      {required Map<String, dynamic> data});

  Future<Either<ErrorModel, SuccessModel>> deleteAddress({
    required int addressId,
  });
}

class AddressRepositoryImpl implements AddressRepository {
  final DatabaseManager databaseManager;
  final AddressDataSource addressDataSource;

  AddressRepositoryImpl(
      {required this.databaseManager, required this.addressDataSource});

  @override
  Future<Either<ErrorModel, AddressModel>> addAddress(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await addressDataSource.addAddress(data: data);
      return Right(response);
    } catch (e, stackTrace) {
      log("ERROR11213 $e");
      return Left(errorParse(e, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, SuccessModel>> deleteAddress(
      {required int addressId}) async {
    try {
      final response =
          await addressDataSource.deleteAddress(addressId: addressId);
      return Right(response);
    } catch (e, stackTrace) {
      return Left(errorParse(e, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, AddressModel>> getAddressById(
      {required int addressId}) async {
    try {
      final userId = databaseManager.getData('USERID');

      final response = await addressDataSource.getAddressById(
          addressId: addressId, userId: userId);
      return Right(response);
    } catch (e, stackTrace) {
      return Left(errorParse(e, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<AddressModel>>> getAddresses() async {
    try {
      final userId = databaseManager.getData('USERID');


      final response = await addressDataSource.getAddressed(userId: userId);

      return Right(response);
    } catch (e, stackTrace) {
      log("ERROR $e");
      return Left(errorParse(e, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, AddressModel>> updateAddress(
      {required int addressId, required Map<String, dynamic> data}) {

    throw UnimplementedError();
  }
}
