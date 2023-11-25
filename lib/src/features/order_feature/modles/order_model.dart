import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  final int? id;
  final DateTime? dateTime;
  final double? netTotal;

  const OrderModel({
    this.id,
    this.dateTime,
    this.netTotal,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return _$OrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        dateTime,
        netTotal,
      ];
}
