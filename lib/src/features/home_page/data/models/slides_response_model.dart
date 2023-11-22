import 'package:bigboss/src/features/home_page/data/models/slide_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'slides_response_model.g.dart';

@JsonSerializable()
class SlidesResponseModel extends Equatable {
  final List<SlideModel>? slides;


  const SlidesResponseModel({
    this.slides,

  });

  factory SlidesResponseModel.fromJson(Map<String, dynamic> json) {
    return _$SlidesResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SlidesResponseModelToJson(this);

  @override
  List<Object?> get props => [
    slides,
  ];
}
