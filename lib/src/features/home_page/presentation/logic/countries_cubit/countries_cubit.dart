import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';

import 'countries_state.dart';



class CountriesCubit extends Cubit<CountriesState> {
  HomeRepository repository;

  CountriesCubit({required this.repository})
      : super(const CountriesState.initial()){
    getCategories();
  }

  Future<void> getCategories() async {
    emit(const CountriesState.loading());

    final result = await repository.getCountries(

    );
    result.fold(
          (ErrorModel error) => emit(
        CountriesState.error(error.error ?? ""),
      ),
          (List<GenericEntity> brands) => emit(
        CountriesState.success(brands),
      ),
    );
  }
}
