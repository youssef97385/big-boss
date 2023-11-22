import 'package:flutter/material.dart';

class ThemeModesData {
  late List<ThemeModeData> values = [];

  ThemeModesData() {
    final platformBrightness =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .platformBrightness;


    final ThemeModeData system = ThemeModeData(
      id: 0,
      titleEn: "Auto",
      titleAr: "تلقائي",
      titleKu: "ئۆتۆماتیک",
      themeModeData: ThemeMode.system,
      isDarkMode: platformBrightness == Brightness.dark,
    );

    final ThemeModeData dark = ThemeModeData(
      id: 1,
      titleEn: "Dark",
      titleAr: "داكن",
      titleKu: "تاريك",
      themeModeData: ThemeMode.dark,
      isDarkMode: true,
    );

    final ThemeModeData light = ThemeModeData(
      id: 2,
      titleEn: "Light",
      titleAr: "ساطع",
      titleKu: "روناك",
      themeModeData: ThemeMode.light,
      isDarkMode: false,
    );

    values.addAll([system, dark, light]);
  }


}

class ThemeModeData {
  final int id;
  final String titleEn;
  final String titleAr;
  final String titleKu;
  final ThemeMode themeModeData;
   bool isDarkMode;

  ThemeModeData({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.titleKu,
    required this.themeModeData,
    required this.isDarkMode,
  });
}
