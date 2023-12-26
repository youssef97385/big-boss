import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel extends Equatable {
  const OfferModel({
    this.id,
    this.enName,
    this.arName,
    this.krName,
    this.link,
  });

  final int? id;
  @JsonKey(name: 'en_Name')
  final String? enName;
  @JsonKey(name: 'aR_Name')
  final String? arName;
  @JsonKey(name: 'kR_Name')
  final String? krName;

  final List<String>? link;

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        enName,
        arName,
        krName,
        link,
      ];
}
