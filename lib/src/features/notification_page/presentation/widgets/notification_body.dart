import 'package:bigboss/src/core/common/widgets/error_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/features/notification_page/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/helpers/notification_parser.dart';
import '../cubit/notification_cubit.dart';
import '../cubit/notification_state.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return SizedBox();
      }, error: (String error) {
        return ErrorView(
            error: error,
            onRefresh: () {
              BlocProvider.of<NotificationCubit>(context).getNotifications();
            });
      }, loading: () {
        return Center(child: LoadingView());
      }, success: (List<NotificationModel> notifications) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: getTextFromJson(notifications[index].title) ??
                                "",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextView(
                            text: getTextFromJson(
                                    notifications[index].notificationText) ??
                                "",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      });
    });
  }
}
