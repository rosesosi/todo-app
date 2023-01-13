import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/database/my_database.dart';
import 'package:todo_app_flutter/database/task.dart';
import 'package:todo_app_flutter/provider/settingsProvider.dart';
import 'package:todo_app_flutter/utils/date_utils.dart';
import 'package:todo_app_flutter/utils/dialog_utils.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>(); // 3shan ast5dm el form bra build
  var titleControler = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.addTask,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              TextFormField(
                style: TextStyle(
                    color: settingProvider.isDarkMode()
                        ? Colors.white
                        : Colors.black),
                controller: titleControler,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please enter a valid title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.title,
                    labelStyle: TextStyle(
                        color: settingProvider.isDarkMode()
                            ? Colors.white
                            : Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                    color: settingProvider.isDarkMode()
                        ? Colors.white
                        : Colors.black),
                controller: descriptionController,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please enter a valid description';
                  }
                  return null;
                },
                minLines: 4,
                maxLines: 4,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.description,
                    labelStyle: TextStyle(
                        color: settingProvider.isDarkMode()
                            ? Colors.white
                            : Colors.black)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.selectDate,
                style: Theme.of(context).textTheme.headline6,
              ),
              InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(MyDateUtils.formatTaskDate(selectedDate),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).primaryColor)),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    insertTask();
                  },
                  child: Text(AppLocalizations.of(context)!.addButton)),
            ],
          ),
        ),
      ),
    );
  }

  var selectedDate = DateTime.now();

  void showTaskDatePicker() async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (userSelectedDate == null) {
      return;
    }
    selectedDate = userSelectedDate;
    setState(() {});
  }

  void insertTask() async {
    //validate form
    if (formKey.currentState?.validate() == false) {
      return;
    }
    // insert task
    Task task = Task(
        title: titleControler.text,
        description: descriptionController.text,
        dateTime: selectedDate);
    DialogUtils.showProgressDialog(
        context, AppLocalizations.of(context)!.loading,
        isDismissible: false);
    try {
      await MyDatabase.insertTask(task);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
          context, AppLocalizations.of(context)!.successAddMessage,
          posActionTitle: AppLocalizations.of(context)!.ok, posAction: () {
        Navigator.pop(context);
      }, isDismissible: false);
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
          context, AppLocalizations.of(context)!.errorMessage,
          posActionTitle: AppLocalizations.of(context)!.tryAgain,
          posAction: () {
            insertTask();
          },
          negActionTitle: AppLocalizations.of(context)!.cancel,
          negAction: () {
            Navigator.pop(context);
          },
          isDismissible: true);
    }
    // de call back we msh sa7 a3ml call back kter gwa b3d
    // await MyDatabase.insertTask(task).then((value){
    //   DialogUtils.hideDialog(context);
    //   DialogUtils.showMessage(context, 'Task inserted Successfuly' , posActionTitle:'Ok' , posAction: (){Navigator.pop(context);} , isDismissible: false);
    //
    // }).onError((error, stackTrace) {
    //   DialogUtils.hideDialog(context);
    //   DialogUtils.showMessage(context, 'Error inserted task' , posActionTitle:'Try Again' , posAction: (){insertTask();} ,negActionTitle: 'cancel',
    //       negAction: (){Navigator.pop(context);},
    //       isDismissible: true);
    // }).timeout(Duration(seconds: 3),onTimeout: (){
    //   DialogUtils.hideDialog(context);
    // });
  }
}
