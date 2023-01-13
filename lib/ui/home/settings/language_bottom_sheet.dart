import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/provider/settingsProvider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                settingProvider.changeLocale('en');
              },
              child: settingProvider.currentLang == 'en'
                  ? getSelectedItem('English')
                  : getUnselectedItem('English')),
          SizedBox(
            height: 12,
          ),
          InkWell(
              onTap: () {
                settingProvider.changeLocale('ar');
              },
              child: settingProvider.currentLang == 'ar'
                  ? getSelectedItem('العربية')
                  : getUnselectedItem('العربية')),
        ],
      ),
    );
  }

  Widget getSelectedItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
        Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }

  Widget getUnselectedItem(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
