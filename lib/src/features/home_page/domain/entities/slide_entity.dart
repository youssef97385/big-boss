import 'package:equatable/equatable.dart';

class SlideEntity extends Equatable {
  final String? series;
  final String? image;

  const SlideEntity({required this.series, required this.image});

  @override
  List<Object?> get props => [series,image];
}
