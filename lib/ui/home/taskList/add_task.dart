import 'package:flutter/material.dart';
import 'package:todo_app_flutter/database/my_database.dart';
import 'package:todo_app_flutter/database/task.dart';
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add New Task',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              TextFormField(
                controller: titleControler,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please enter a valid title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
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
                  labelText: 'description',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select Date',
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
                  child: Text('Submit')),
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
    DialogUtils.showProgressDialog(context, 'Loading...', isDismissible: false);
    try {
      await MyDatabase.insertTask(task);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Task inserted Successfuly',
          posActionTitle: 'Ok', posAction: () {
        Navigator.pop(context);
      }, isDismissible: false);
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Error inserted task',
          posActionTitle: 'Try Again',
          posAction: () {
            insertTask();
          },
          negActionTitle: 'cancel',
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
