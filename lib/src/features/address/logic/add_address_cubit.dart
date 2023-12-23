import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:bigboss/src/features/address/data/repository/address_repository.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/data/models/error_model/error_model.dart';
import 'add_address_state.dart';
import 'address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddressRepository repository;

  AddAddressCubit({required this.repository})
      : super(const AddAddressState.initial());

  Future<void> addAddress(Map<String,dynamic> data) async {
    emit(const AddAddressState.loading());

    final result = await repository.addAddress(data:data);
    result.fold(
      (ErrorModel error) => emit(
        AddAddressState.error(error.error ?? error.message??""),
      ),
      (_) => emit(
        AddAddressState.success(),
      ),
    );
  }
}
