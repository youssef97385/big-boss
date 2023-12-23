
import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'address_state.freezed.dart';

@freezed
abstract class AddressSatate with _$AddressSatate {
  const factory AddressSatate.initial() = _Initial;

  const factory AddressSatate.loading() = _Loading;

  const factory AddressSatate.error(String message) = _Error;

  const factory AddressSatate.success(
      List<AddressModel> brands) = _Success;

  const factory AddressSatate.successDeleted(
      ) = _SuccessDeleted;
  const factory AddressSatate.deleting(
      ) = _Deleting;
}
