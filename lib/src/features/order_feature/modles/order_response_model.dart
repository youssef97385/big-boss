import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_response_model.g.dart';

@JsonSerializable()
class OrderResponseModel extends Equatable {
  final List<OrderModel>? orders;

  const OrderResponseModel({
    this.orders,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return _$OrderResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderResponseModelToJson(this);

  @override
  List<Object?> get props => [
        orders,
      ];
}
