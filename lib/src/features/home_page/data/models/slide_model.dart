import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'slide_model.g.dart';

@JsonSerializable()
class SlideModel extends Equatable {
  final int? id;
  final String? series;
  final String? link;

  const SlideModel({
    this.id,
    this.link,
    this.series,
  });

  factory SlideModel.fromJson(Map<String, dynamic> json) {
    return _$SlideModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SlideModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        link,
        series,
      ];
}
