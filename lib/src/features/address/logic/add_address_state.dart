
import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'add_address_state.freezed.dart';

@freezed
abstract class AddAddressState with _$AddAddressState {
  const factory AddAddressState.initial() = _Initial;

  const factory AddAddressState.loading() = _Loading;

  const factory AddAddressState.error(String message) = _Error;

  const factory AddAddressState.success(
      ) = _Success;
}
