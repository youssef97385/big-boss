
import 'package:equatable/equatable.dart';
import '../../../app/logic/app_settings.dart';
import '../../../injection.dart';

class OfferEntity extends Equatable {
  OfferEntity({
    this.id,
    this.enName,
    this.arName,
    this.krName,
    this.link,
    this.netTotal,
    this.arDescritpion,
    this.krDescription,
    this.enDescription,
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
  }

  final int? id;
  final String? enName;
  final String? arName;
  final String? krName;

  final String? enDescription;
  final String? arDescritpion;
  final String? krDescription;

  final List<String?>? link;

  final double? netTotal;

  late String? name;
  late String? description;

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
