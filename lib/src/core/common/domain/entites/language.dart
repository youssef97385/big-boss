import 'package:flutter/material.dart';

class Languages {
  late List<Language> languagesData = [];

  Languages() {
    final Language ar = Language(
      id: 2,
      backendLangCode: 'ar',
      shortDisplayLabel: 'Ar',
      fullDisplayLabel: 'عربي',
      local: Locale('ar', 'IQ'),
    );

    final Language en = Language(
      id: 3,
      backendLangCode: 'en',
      shortDisplayLabel: 'En',
      fullDisplayLabel: 'English',
      local: Locale('en', 'US'),
    );
    final Language ku = Language(
      id: 1,
      backendLangCode: 'ku',
      shortDisplayLabel: 'Ku',
      fullDisplayLabel: 'کوردی',
      local: Locale('ar', 'EG'),
    );

    languagesData.addAll([ ar, en,ku]);
  }
}

class Language {
  final int id;
  final String backendLangCode;
  final String shortDisplayLabel;
  final String fullDisplayLabel;
  final Locale local;

  Language({
    required this.id,
    required this.backendLangCode,
    required this.shortDisplayLabel,
    required this.fullDisplayLabel,
    required this.local,
  });
}
