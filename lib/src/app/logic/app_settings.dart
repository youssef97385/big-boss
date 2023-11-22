import 'package:flutter/cupertino.dart';

import '../../core/common/domain/entites/language.dart';
import '../../core/common/domain/entites/theme_modes.dart';

import '../../core/utils/managers/database/database_manager.dart';

class AppSettings {
  final DatabaseManager databaseManager;
  final Languages _languages = Languages();
  final ThemeModesData _themeModesData = ThemeModesData();

  late Language? _selectedLanguage;
  late ThemeModeData? _selectedThemeModeData;
  String? _apiBaseUrl;
  bool? _hasConnection;

  AppSettings({required this.databaseManager});

  //* API Base Url
  String? get apiBaseUrl => _apiBaseUrl;

  set apiBaseUrl(String? value) => _apiBaseUrl = value;

  //* Has Connection
  bool? get hasConnection => _hasConnection;

  set hasConnection(bool? value) => _hasConnection = value;

  //* Languages
  Languages get languages {
    return _languages;
  }

  //* selected language
  Language get selectedLanguage {
    return _selectedLanguage!;
  }

  //! call in the root widget
  void changeSelectedLanguage(Locale selectedLocal) {
    _selectedLanguage = _languages.languagesData
        .firstWhere((element) => element.local == selectedLocal);
  }

  //* theme modes data

  int? get themeID {
    return databaseManager.getData("themeID") as int?;
  }

  //! call in the root widget
  set themeID(int? value) {
    databaseManager.saveData("themeID", value);
    _selectedThemeModeData =
        _themeModesData.values.firstWhere((element) => element.id == value);
  }

  ThemeModesData get themeModesData {
    return _themeModesData;
  }

  //* selected theme mode data
  ThemeModeData get selectedThemeModeData {
    return _selectedThemeModeData!;
  }


  //* Token
  String? get token {
    String? result = databaseManager.getData('token');
    return result;
  }

  set token(String? value) {
    databaseManager.saveData("token", value);
  }
  //* Token
  String? get userId {
    String? result = databaseManager.getData('userID');
    return result;
  }

  set userId(String? value) {
    databaseManager.saveData("userID", value);
  }
}
