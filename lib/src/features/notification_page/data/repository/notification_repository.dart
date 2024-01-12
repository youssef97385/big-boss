
import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/utils/helpers/error_parser.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/notification_page/data/data_source/notification_data_source.dart';
import 'package:bigboss/src/features/notification_page/data/models/notification_model.dart';
import 'package:bigboss/src/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class NotificationRepo {
  Future<Either<ErrorModel, List<NotificationModel>>> getNotifications();
}

class NotificationRepoImpl implements NotificationRepo {
  final NotificationDataSource dataSource;

  NotificationRepoImpl({
    required this.dataSource,
  });

  @override
  Future<Either<ErrorModel, List<NotificationModel>>> getNotifications() async {
    try {
      String? userId = serviceLocator<DatabaseManager>().getData("USERID");

      final result = await dataSource.getNotifications(userId: userId ?? "");
      return Right(result);
    } on DioError catch (e, stackTrace) {
      return Left(errorParse(e, stackTrace));
    } catch (e, stackTrace) {
      return Left(errorParse(e, stackTrace));
    }
  }
}
