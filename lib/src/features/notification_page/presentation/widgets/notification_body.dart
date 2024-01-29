import 'package:bigboss/src/core/common/widgets/error_view.dart';
import 'package:bigboss/src/core/common/widgets/loading_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/core/constants/image_name.dart';
import 'package:bigboss/src/features/notification_page/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/helpers/date_formatter.dart';
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
                    elevation: 0,
                    color: Color(0xFFF2F7F3),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                ImageNameHelper.getValue(ImageName.logo),
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text: getTextFromJson(
                                              notifications[index].title) ??
                                          "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    TextView(
                                      text: getTextFromJson(notifications[index]
                                              .notificationText) ??
                                          "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(height: 1.3),
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextView(
                                text: formatDateWithHour(
                                        notifications[index].timestamp) ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(height: 1.3),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
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
