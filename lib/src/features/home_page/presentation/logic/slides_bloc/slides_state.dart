import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'slides_state.freezed.dart';

@freezed
abstract class SlidesState with _$SlidesState {
  const factory SlidesState.initial() = _Initial;

  const factory SlidesState.loading() = _Loading;

  const factory SlidesState.error(String message) = _Error;

  const factory SlidesState.success(
      List<SlideEntity> slides) = _Success;
}
