import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:bigboss/src/features/address/data/repository/address_repository.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/data/models/error_model/error_model.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressSatate> {
  AddressRepository repository;

  AddressCubit({required this.repository})
      : super(const AddressSatate.initial()) {
    // getAddress();
  }

  Future<void> getAddress() async {
    emit(const AddressSatate.loading());

    final result = await repository.getAddresses();
    result.fold(
      (ErrorModel error) => emit(
        AddressSatate.error(error.error ?? ""),
      ),
      (List<AddressModel> addresses) => emit(
        AddressSatate.success(addresses),
      ),
    );
  }
  Future<void> deleteAddress(addressId) async {

    emit(const AddressSatate.deleting());

    final result = await repository.deleteAddress(addressId: addressId);
    result.fold(
      (ErrorModel error) => emit(
        AddressSatate.error(error.error ?? ""),
      ),
          (_)  {
              getAddress();
          }
    );
  }
}
