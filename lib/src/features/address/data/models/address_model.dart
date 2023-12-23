import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Equatable {
  final int? id;
  @JsonKey(name: "attitude")
  final String? longitude;
  @JsonKey(name: "latitude")
  final String? latitude;
  @JsonKey(name: "remark")
  final String? remark;

  const AddressModel({
    this.id,
    this.remark,
    this.longitude,
    this.latitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return _$AddressModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
      ];
}
