import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/my_theme.dart';
import 'package:todo_app_flutter/provider/settingsProvider.dart';
import 'package:todo_app_flutter/ui/home/home_screen.dart';
import 'package:todo_app_flutter/ui/home/taskList/edit_task_screen.dart';

import 'firebase_options.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (buildContext) => SettingsProvider(),
      // shared instance // oop wa7d y7sl creat 3la mostawa el app kolo //singlton
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  late SettingsProvider settingProvider;

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingsProvider>(context);
    getValueFromSharedPref();

    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        //AppLocalizations.supportedLocales,
        Locale('en', ''), // English, no country code
        Locale('ar', ''),
      ],
      locale: Locale(settingProvider.currentLang),
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: settingProvider.currentTheme,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        EditTaskScreen.routeName: (_) => EditTaskScreen(),
      },
    );
  }

  void getValueFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final String? local = prefs.getString('local');
    final String? thememode = prefs.getString('theme');
    if (thememode == 'dark') {
      settingProvider.changeTheme(ThemeMode.dark);
    } else {
      settingProvider.changeTheme(ThemeMode.light);
    }
    settingProvider.changeLocale(local ?? 'en');
  }
}
