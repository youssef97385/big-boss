import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';
import 'accounts_state.dart';




class AccountsCubit extends Cubit<AccountsState> {
  HomeRepository repository;

  AccountsCubit({required this.repository})
      : super(const AccountsState.initial()){
    getCategories();
  }

  Future<void> getCategories() async {
    emit(const AccountsState.loading());

    final result = await repository.getAccounts(

    );
    result.fold(
          (ErrorModel error) => emit(
        AccountsState.error(error.error ?? ""),
      ),
          (List<GenericEntity> brands) => emit(
        AccountsState.success(brands),
      ),
    );
  }
}
