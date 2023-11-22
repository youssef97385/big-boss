import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_model.g.dart';

@JsonSerializable()
class GenericModel extends Equatable {
  const GenericModel({
    this.id,
    this.enName,
    this.arName,
    this.krName,
    this.remark,
    this.link,
    this.subCategories,
  });

  final int? id;
  @JsonKey(name: 'en_Name')
  final String? enName;
  @JsonKey(name: 'ar_Name')
  final String? arName;
  @JsonKey(name: 'kR_Name')
  final String? krName;
  final String? remark;
  final String? link;
  final List<GenericModel>? subCategories;

  factory GenericModel.fromJson(Map<String, dynamic> json) =>
      _$GenericModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenericModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        enName,
        arName,
        krName,
        remark,
        link,
    subCategories,
      ];
}
