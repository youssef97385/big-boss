import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';
import 'brands_state.dart';


class BrandsCubit extends Cubit<BrandsState> {
  HomeRepository repository;

  BrandsCubit({required this.repository})
      : super(const BrandsState.initial()){
    getBrands();
  }

  Future<void> getBrands() async {
    emit(const BrandsState.loading());

    final result = await repository.getBrands(

    );
    result.fold(
          (ErrorModel error) => emit(
        BrandsState.error(error.error ?? ""),
      ),
          (List<GenericEntity> brands) => emit(
        BrandsState.success(brands),
      ),
    );
  }
}
