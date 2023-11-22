import 'package:flutter/material.dart';

import '../../../app/logic/app_settings.dart';
import '../../../injection.dart';


bool isDarkMode(BuildContext context) {
  final bool autoModeEnabled =
      serviceLocator<AppSettings>().selectedThemeModeData.id == 0;
  final bool isDarkMode;
  if (autoModeEnabled) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    isDarkMode = brightness == Brightness.dark;
  } else {
    isDarkMode = serviceLocator<AppSettings>().selectedThemeModeData.isDarkMode;
  }
  return isDarkMode;
}
