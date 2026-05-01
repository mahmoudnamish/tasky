import 'package:flutter/material.dart';

import '../services/preferences_manager.dart';

class ThemeController {
  //value notifier                                        //initial type
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  ///علشان عايز يتعمله انشليز مره وحده بس ع الليف سيكل بتاع الابلكيشن ك كل

  init() {
    bool resultTheme = PreferencesManager().getBool('theme') ?? true;
    themeNotifier.value = resultTheme == true
        ? ThemeMode.dark
        : ThemeMode.light;

    ///if(resul) {
    ///themeNotifier.value = thememode.dark
    ///}else{
    ///themeNotifier.value = thememode.light
    ///}
  }

  static toggleTheme() async {
    ///bool resurce = SharedManager().get('theme');
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool(
        'theme',
        false,
      ); // حطهالي بي غلط علشان يجيب الليت
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool('theme', true);
    }
  }

  static bool isDark() {
    return themeNotifier.value == ThemeMode.dark;
  }
}
