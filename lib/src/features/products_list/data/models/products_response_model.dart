import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response_model.g.dart';

@JsonSerializable()
class ProductsResponseModel extends Equatable {
  final List<ProductModel>? data;

  final int? pageNumber;
  final int? totalPages;

  const ProductsResponseModel({
    this.data,
    this.totalPages,
    this.pageNumber,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ProductsResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductsResponseModelToJson(this);

  @override
  List<Object?> get props => [
    data,
    totalPages,
    pageNumber,

  ];
}
