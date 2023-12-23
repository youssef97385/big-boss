import 'package:bigboss/src/features/address/data/models/address_model.dart';
import 'package:bigboss/src/features/home_page/data/models/slide_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'address_response_model.g.dart';

@JsonSerializable()
class AddressResponseModel extends Equatable {
  final List<AddressModel>? addresses;


  const AddressResponseModel({
    this.addresses,

  });

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) {
    return _$AddressResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressResponseModelToJson(this);

  @override
  List<Object?> get props => [
    addresses,
  ];
}
