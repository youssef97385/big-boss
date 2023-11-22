import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'accounts_state.freezed.dart';

@freezed
abstract class AccountsState with _$AccountsState {
  const factory AccountsState.initial() = _Initial;

  const factory AccountsState.loading() = _Loading;

  const factory AccountsState.error(String message) = _Error;

  const factory AccountsState.success(
      List<GenericEntity> accounts) = _Success;
}
