import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/features/notification_page/data/models/notification_model.dart';
import 'package:bigboss/src/features/notification_page/data/repository/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationRepo repository;

  NotificationCubit({required this.repository}) : super(const NotificationState.initial()) {
    getNotifications();
  }

  Future<void> getNotifications() async {
    emit(const NotificationState.loading());

    final result = await repository.getNotifications();
    result.fold(
          (ErrorModel error) => emit(
        NotificationState.error(error.message  ?? error.title??""),
      ),
          (List<NotificationModel> model) => emit(
        NotificationState.success(model),
      ),
    );
  }
}
