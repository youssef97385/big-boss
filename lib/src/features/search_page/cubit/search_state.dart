import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'search_state.freezed.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;

  const factory SearchState.loading() = _Loading;

  const factory SearchState.error(String message) = _Error;

  const factory SearchState.success(
      List<ProductEntity> products,) = _Success;
}
