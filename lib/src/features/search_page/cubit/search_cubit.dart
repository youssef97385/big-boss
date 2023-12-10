import 'dart:developer';

import 'package:bigboss/src/features/products_list/data/repository/products_repository.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_state.dart';
import 'package:bigboss/src/features/search_page/cubit/search_state.dart';
import 'package:bigboss/src/features/search_page/data_source/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/data/models/error_model/error_model.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchRepo repository;

  SearchCubit({required this.repository}) : super(const SearchState.initial());

  Future<void> search({
    required String value,
  }) async {
    emit(SearchState.loading());
    final result = await repository.search(
      value,
    );
    result.fold(
        (ErrorModel error) => emit(
              SearchState.error(error.error ?? ""),
            ), (List<ProductEntity> products) {
      emit(
        SearchState.success(
          products,
        ),
      );
    });
  }
  Future<void> clear() async {
    emit(SearchState.loading());
   emit(SearchState.success([]));
  }
}
