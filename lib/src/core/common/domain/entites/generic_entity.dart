import 'package:bigboss/src/app/logic/app_settings.dart';
import 'package:bigboss/src/injection.dart';
import 'package:equatable/equatable.dart';


class GenericEntity extends Equatable {
  final int? id;
  late final String? name;
  final String? image;
  final List<GenericEntity>? genericEntityList;

   GenericEntity({
    this.id,
    this.image,
    required String enName,
    required String arName,
    required String krName,
     this.genericEntityList,

  }){

     final selectedLang = serviceLocator<AppSettings>().selectedLanguage;
     if(selectedLang.id == 1){
       name = krName;
     }else if(selectedLang.id == 2){
       name = arName;
     }else{
       name = enName;
     }

  }

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    genericEntityList,

  ];
}
