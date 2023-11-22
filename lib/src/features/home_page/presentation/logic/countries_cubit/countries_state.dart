import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'countries_state.freezed.dart';

@freezed
abstract class CountriesState with _$CountriesState {
  const factory CountriesState.initial() = _Initial;

  const factory CountriesState.loading() = _Loading;

  const factory CountriesState.error(String message) = _Error;

  const factory CountriesState.success(
      List<GenericEntity> countries) = _Success;
}
