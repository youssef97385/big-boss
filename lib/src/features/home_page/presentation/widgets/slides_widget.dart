import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/common/widgets/error_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/slides_bloc/slides_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/slides_bloc/slides_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../domain/entities/slide_entity.dart';

class SlidesWidget extends StatelessWidget {
  const SlidesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SlidesCubit, SlidesState>(builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return const SizedBox();
      }, error: (String error) {
        return ErrorView(error: error, onRefresh: () {});
      }, success: (List<SlideEntity> slides) {
        print(slides);
        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: slides
              .map((item) => Container(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: Image.network(item.image ?? "",
                          fit: BoxFit.fill, width: 1000.0),
                    ),
                  ))
              .toList(),
        );
      }, loading: () {
        return LoadingView();
      });
    });
  }
}