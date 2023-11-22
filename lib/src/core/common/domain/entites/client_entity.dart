import 'package:equatable/equatable.dart';


class ClientEntity extends Equatable {
  final String? id;
  final String? name;
  final String? phone;
  final String? address;

  ClientEntity({
    this.id,
    this.name,
    this.phone,
    this.address,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        address,
      ];
}
