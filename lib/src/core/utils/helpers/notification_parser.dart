import 'dart:convert';

import '../../../app/logic/app_settings.dart';
import '../../../injection.dart';

String getTextFromJson(String? jsonText){

  try{
  Map data = jsonDecode(jsonText??"{}");
  final selectedLang = serviceLocator<AppSettings>().selectedLanguage;
  if(selectedLang.id == 1){

    return data["KR"];

  }else if(selectedLang.id == 2){
    return data["AR"];
  }else{
    return data["EN"];
  }

  }catch(e){
    return "";
  }



}