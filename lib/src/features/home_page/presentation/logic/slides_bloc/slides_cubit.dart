import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/slides_bloc/slides_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';


class SlidesCubit extends Cubit<SlidesState> {
  HomeRepository slidesRepository;

  SlidesCubit({required this.slidesRepository})
      : super(const SlidesState.initial()){
    getSlides();
  }

  Future<void> getSlides() async {
    emit(const SlidesState.loading());

    final result = await slidesRepository.getSlides(

    );
    result.fold(
          (ErrorModel error) => emit(
        SlidesState.error(error.error ?? ""),
      ),
          (List<SlideEntity> slides) => emit(
        SlidesState.success(slides),
      ),
    );
  }
}
