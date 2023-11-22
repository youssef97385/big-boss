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
    name = enName;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    genericEntityList,

  ];
}
