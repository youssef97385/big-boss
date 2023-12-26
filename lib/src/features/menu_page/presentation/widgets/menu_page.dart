import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/app/routes/router.gr.dart';
import 'package:bigboss/src/core/common/widgets/card_view.dart';
import 'package:bigboss/src/features/menu_page/presentation/logic/delete_account_bloc/delete_account_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/app_bar_view.dart';
import '../../../../core/common/widgets/text_view.dart';
import '../../../../core/utils/managers/database/database_manager.dart';
import '../../../../injection.dart';
import 'menu_body.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBarView(
          appBarTitle: 'Profile'.tr(),
        ),
      ),
      body: BlocProvider(create: (context)=>serviceLocator<DeleteAccounCubit>(),child: MenuBody(),)
    );
  }
}
