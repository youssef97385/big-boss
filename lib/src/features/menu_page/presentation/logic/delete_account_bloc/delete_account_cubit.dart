import 'package:bigboss/src/features/login/domain/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';
import 'delete_account_state.dart';

class DeleteAccounCubit extends Cubit<DeleteAccountState> {
  final LoginRepository repository;

  DeleteAccounCubit({required this.repository})
      :
        super(const DeleteAccountState.initial());

  Future<void> deleteAccount() async {
    emit(const DeleteAccountState.loading());
    final userIssues = await repository.deleteAccount();
    emit(
      userIssues.fold((ErrorModel error) {

        return DeleteAccountState.error(errorModel: error);
      }, (_) {
        return DeleteAccountState.success();
      }),
    );
  }
}
