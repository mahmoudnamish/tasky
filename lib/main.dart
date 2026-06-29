import 'package:flutter/material.dart';
import 'package:tasky/constants/storage_key.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
 //value notifier                                        //initial type
// ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  ThemeController().init();
  String? username = PreferencesManager().getString(StorageKey.username);
  // final pref = PreferencesManager();
  // String? username = pref.getString('username');
  // final pref = await SharedPreferences.getInstance();
  // String? username = pref.getString('username');
  // bool resultTheme = PreferencesManager().getBool('theme')  ?? true;
  // if(resultTheme ){
  //   themeNotifier.value = ThemeMode.dark;
  // }else{
  //   themeNotifier.value = ThemeMode.light;
  // }

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.username});

  String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable:ThemeController.themeNotifier ,
      builder:(context , ThemeMode valueTheme , Widget? child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tasky app',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: valueTheme,   /// togen on theme mode
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      }
    );
  }
}
