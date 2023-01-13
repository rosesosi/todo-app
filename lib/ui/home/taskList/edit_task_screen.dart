import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/database/my_database.dart';
import 'package:todo_app_flutter/database/task.dart';
import 'package:todo_app_flutter/my_theme.dart';
import 'package:todo_app_flutter/provider/settingsProvider.dart';
import 'package:todo_app_flutter/utils/date_utils.dart';
import 'package:todo_app_flutter/utils/dialog_utils.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'EditTaskScreen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    Task? args = ModalRoute.of(context)?.settings.arguments as Task;
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: MyTheme.lightPrimary,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                    color: settingProvider.isDarkMode()
                        ? Colors.black
                        : Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.projectName,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: settingProvider.isDarkMode()
                            ? Colors.black
                            : Colors.white),
                  )
                ],
              ),
            ),
            Positioned(
                top: 100,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  width: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.height * .80,
                  decoration: BoxDecoration(
                    color: settingProvider.isDarkMode()
                        ? MyTheme.darkPrimary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.editTask,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: settingProvider.isDarkMode()
                                ? Colors.white
                                : Colors.black),
                        onChanged: (value) {
                          args.title = value;
                        },
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.title,
                            labelStyle: TextStyle(
                                color: settingProvider.isDarkMode()
                                    ? Colors.white
                                    : Colors.black)),
                        initialValue: args.title,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: settingProvider.isDarkMode()
                                ? Colors.white
                                : Colors.black),
                        onChanged: (value) {
                          args.description = value;
                        },
                        initialValue: args.description,
                        minLines: 4,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.description,
                            labelStyle: TextStyle(
                                color: settingProvider.isDarkMode()
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.selectDate,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          IconButton(
                              onPressed: () {
                                showTaskDatePicker();
                              },
                              icon: Icon(
                                Icons.calendar_month_sharp,
                                color: MyTheme.lightPrimary,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          (selectedDate == null)
                              ? MyDateUtils.formatTaskDate(args.dateTime)
                              : MyDateUtils.formatTaskDate(selectedDate),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: Theme.of(context).primaryColor)),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            editTask(args);
                          },
                          child: Text(AppLocalizations.of(context)!.saveChange),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  var selectedDate;

  void showTaskDatePicker() async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: (selectedDate == null) ? DateTime.now() : selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (userSelectedDate == null) {
      return;
    }
    selectedDate = userSelectedDate;

    setState(() {});
  }

  void editTask(Task task) async {
    if (selectedDate == null) {
      selectedDate = task.dateTime;
    }
    task.dateTime = selectedDate;
    DialogUtils.showProgressDialog(
        context, AppLocalizations.of(context)!.loading,
        isDismissible: false);
    try {
      await MyDatabase.editTaskDetails(task);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
          context, AppLocalizations.of(context)!.successUpdate,
          posActionTitle: AppLocalizations.of(context)!.ok, posAction: () {
        Navigator.pop(context);
      }, isDismissible: false);
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
          context, AppLocalizations.of(context)!.errorMessage,
          posActionTitle: AppLocalizations.of(context)!.tryAgain,
          posAction: () {
            editTask(task);
          },
          negActionTitle: AppLocalizations.of(context)!.cancel,
          negAction: () {
            Navigator.pop(context);
          },
          isDismissible: true);
    }
  }
}
