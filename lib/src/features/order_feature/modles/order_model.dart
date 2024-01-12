import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../products_list/data/models/product_model.dart';
import '../data/order_product_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  final int? id;
  final DateTime? dateTime;
  final double? netTotal;
  final int? orderStatus;
  final OrderProductModel? products;
  final int? qty;

  const OrderModel({
    this.id,
    this.dateTime,
    this.netTotal,
    this.orderStatus,
    this.products,
    this.qty,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return _$OrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        dateTime,
        netTotal,orderStatus,products,qty
      ];
}
