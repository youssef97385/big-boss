import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_model.g.dart';

@JsonSerializable()
class ClientModel extends Equatable {
  final String? id;
  final String? name;
  final String? phone;
  final String? address;

  const ClientModel({
    this.id,
    this.name,
    this.phone,
    this.address,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return _$ClientModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);




  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        address,
      ];
}
