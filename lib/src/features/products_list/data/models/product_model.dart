import 'package:bigboss/src/features/products_list/data/models/price_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  final int? id;
  @JsonKey(name: "en_Name")
  final String? enName;
  @JsonKey(name: "aR_Name")
  final String? arName;
  @JsonKey(name: "kR_Name")
  final String? krName;
  @JsonKey(name: "eN_Description")
  final String? enDescription;
  @JsonKey(name: "aR_Descritpion")
  final String? arDescription;
  @JsonKey(name: "kR_Description")
  final String? krDescription;
  @JsonKey(name: "eN_ShippingDetails")
  final String? enShippingDetails;
  @JsonKey(name: "aR_ShippingDetails")
  final String? arShippingDetails;
  @JsonKey(name: "kR_ShippingDetails")
  final String? krShippingDetails;
  final String? sizes;
  final String? colors;
  @JsonKey(name: "uoMs")
  final String? uoMs;
  final String? weight;
  final bool? inStock;

  final List<String>? link;
  final List<PriceModel>? priceLists;

  final double? discountPercentage;

  const ProductModel({
    this.id,
    this.link,
    this.enName,
    this.arName,
    this.krName,
    this.enDescription,
    this.arDescription,
    this.krDescription,
    this.enShippingDetails,
    this.arShippingDetails,
    this.krShippingDetails,
    this.sizes,
    this.colors,
    this.uoMs,
    this.weight,
    this.inStock,
    this.priceLists,
    this.discountPercentage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return _$ProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        link,
        enName,
        arName,
        krName,
        enDescription,
        arDescription,
        krDescription,
        enShippingDetails,
        arShippingDetails,
        krShippingDetails,
        sizes,
        colors,
        uoMs,
        weight,
        inStock,
        discountPercentage,
        priceLists,
      ];
}
