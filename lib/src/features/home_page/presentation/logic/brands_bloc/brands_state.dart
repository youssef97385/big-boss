import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'brands_state.freezed.dart';

@freezed
abstract class BrandsState with _$BrandsState {
  const factory BrandsState.initial() = _Initial;

  const factory BrandsState.loading() = _Loading;

  const factory BrandsState.error(String message) = _Error;

  const factory BrandsState.success(
      List<GenericEntity> brands) = _Success;
}
