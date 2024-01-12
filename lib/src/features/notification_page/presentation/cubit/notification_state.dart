import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/notification_page/data/models/notification_model.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;

  const factory NotificationState.loading() = _Loading;

  const factory NotificationState.error(String message) = _Error;

  const factory NotificationState.success(List<NotificationModel> accounts) = _Success;
}
