import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/database/my_database.dart';
import 'package:todo_app_flutter/database/task.dart';
import 'package:todo_app_flutter/my_theme.dart';
import 'package:todo_app_flutter/provider/settingsProvider.dart';
import 'package:todo_app_flutter/ui/home/taskList/edit_task_screen.dart';
import 'package:todo_app_flutter/utils/dialog_utils.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          children: [
            SlidableAction(
              onPressed: (buildContext) {
                deleteTask();
              },
              backgroundColor: Colors.red,
              label: 'Delete',
              icon: Icons.delete,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            )
          ],
          motion: DrawerMotion(),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, EditTaskScreen.routeName,
                arguments: widget.task);
          },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: settingProvider.isDarkMode()
                    ? MyTheme.darkPrimary
                    : Colors.white),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: widget.task.isDone
                          ? MyTheme.greenColor
                          : Theme.of(context).primaryColor),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.task.title,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: widget.task.isDone
                                ? MyTheme.greenColor
                                : Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.task.description,
                        style: TextStyle(
                            color: settingProvider.isDarkMode()
                                ? Colors.white
                                : Colors.black),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    MyDatabase.markAsDone(widget.task);
                  },
                  child: (widget.task.isDone)
                      ? Text(AppLocalizations.of(context)!.done,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: MyTheme.greenColor))
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Theme.of(context).primaryColor),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(
      context,
      AppLocalizations.of(context)!.deleteMessage,
      posActionTitle: AppLocalizations.of(context)!.yes,
      negActionTitle: AppLocalizations.of(context)!.cancel,
      posAction: () async {
        DialogUtils.showProgressDialog(
            context, AppLocalizations.of(context)!.loading);
        await MyDatabase.deleteTask(widget.task);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(
            context, AppLocalizations.of(context)!.deleteMessage,
            posActionTitle: AppLocalizations.of(context)!.ok, negAction: () {
          //todo : return the deleted task,
        });
      },
    );
  }
}
