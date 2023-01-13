import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/my_theme.dart';
import 'package:todo_app_flutter/provider/settingsProvider.dart';
import 'package:todo_app_flutter/ui/home/settings/language_bottom_sheet.dart';
import 'package:todo_app_flutter/ui/home/settings/theme_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: MyTheme.lightPrimary)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  settingProvider.currentLang == 'en' ? 'English' : 'العربية',
                  style: TextStyle(color: MyTheme.lightPrimary),
                ),
                IconButton(
                    onPressed: () {
                      showLanguageBottomSheet();
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyTheme.lightPrimary,
                    )),
              ],
            ),
          ),

          //////////////////////////////////////////////////////////////////////////////
          SizedBox(
            height: 30,
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: MyTheme.lightPrimary)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  settingProvider.isDarkMode()
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
                  style: TextStyle(color: MyTheme.lightPrimary),
                ),
                IconButton(
                    onPressed: () {
                      showThemeBottomSheet();
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyTheme.lightPrimary,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return LanguageBottomSheet();
        });
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ThemeBottomSheet();
        });
  }
}
