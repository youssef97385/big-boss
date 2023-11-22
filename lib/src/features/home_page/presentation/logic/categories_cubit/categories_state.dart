import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'categories_state.freezed.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = _Initial;

  const factory CategoriesState.loading() = _Loading;

  const factory CategoriesState.error(String message) = _Error;

  const factory CategoriesState.success(
      List<GenericEntity> categories) = _Success;
}
