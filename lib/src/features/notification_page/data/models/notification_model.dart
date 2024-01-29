import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final String? title;

  final String? notificationText;
  final DateTime? timestamp;

  const NotificationModel({
    this.title,
    this.notificationText,
    this.timestamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return _$NotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [
        title,
        notificationText,
        timestamp,
      ];
}
