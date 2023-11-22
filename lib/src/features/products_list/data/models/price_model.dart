import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_model.g.dart';

@JsonSerializable()
class PriceModel extends Equatable {
  final int? id;

  final int? fromQTY;
  final int? toQTY;
  final double? price;
  final String? remark;


  const PriceModel({
    this.id,
    this.remark,
    this.fromQTY,
    this.toQTY,
    this.price,

  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return _$PriceModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    remark,
    price,
    fromQTY,
    toQTY,

  ];
}
