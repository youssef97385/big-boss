import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../app/logic/app_settings.dart';
import '../../../../injection.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel extends Equatable {
  OfferModel({
    this.id,
    this.enName,
    this.arName,
    this.krName,
    this.link,
    this.netTotal,
    this.arDescritpion,
    this.krDescription,
    this.enDescription,
    this.startDate,
    this.endDate,
  }) {
    final selectedLang = serviceLocator<AppSettings>().selectedLanguage;
    if (selectedLang.id == 1) {
      name = krName ?? "";

      description = krDescription ?? "";
    } else if (selectedLang.id == 2) {
      name = arName ?? "";
      description = arDescritpion ?? "";
    } else {
      name = enName ?? "";

      description = enDescription ?? "";
    }

    log("DESC## $description");
  }

  final int? id;
  @JsonKey(name: 'en_Name')
  final String? enName;
  @JsonKey(name: 'aR_Name')
  final String? arName;
  @JsonKey(name: 'kR_Name')
  final String? krName;

  @JsonKey(name: 'eN_Description')
  final String? enDescription;
  @JsonKey(name: 'aR_Descritpion')
  final String? arDescritpion;
  @JsonKey(name: 'kR_Description')
  final String? krDescription;

  final List<String?>? link;

  @JsonKey(name: 'netTotal')
  final double? netTotal;

  late String? name;
  late String? description;

  final DateTime? startDate;
  final DateTime? endDate;

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
        netTotal,
        description,
        name,
      ];
}
