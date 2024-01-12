import 'package:bigboss/src/features/notification_page/presentation/cubit/notification_cubit.dart';
import 'package:bigboss/src/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/app_bar_view.dart';
import 'notification_body.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBarView(
          appBarTitle: "Notifications".tr(),
        ),
      ),
      body: BlocProvider(
        create: (context) => serviceLocator<NotificationCubit>(),
        child: NotificationBody(),
      ),
    );
  }
}
