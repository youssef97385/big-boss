import 'dart:io';

import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'src/core/utils/managers/database/database_manager.dart';

import 'src/app/logic/app_bloc.dart';
import 'src/app/widget/app.dart';
import 'src/injection.dart' as injection;
import 'src/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  Hive.registerAdapter(CartItemEntityAdapter());
  await injection.init();
  await serviceLocator<DatabaseManager>().openBox();
  await serviceLocator<AppBloc>().init();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'IQ'),Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}
