import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.freezed.dart';

@freezed
abstract class AppEvent with _$AppEvent {
  const factory AppEvent.requestRefresh() = _RequestRefresh;
}
