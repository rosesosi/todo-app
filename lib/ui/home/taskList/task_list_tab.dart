import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter/database/my_database.dart';
import 'package:todo_app_flutter/database/task.dart';
import 'package:todo_app_flutter/ui/home/taskList/task_item.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  // List<Task> allTasks =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadTask();
  }

  @override
  Widget build(BuildContext context) {
    // if(allTasks.isEmpty){
    //   loadTask();
    // }
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            shrink: true,
            showYears: false,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 30)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            dayNameColor: const Color(0xFF333A47),
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en',
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
              child:
                  // allTasks.isEmpty?const Center(child: CircularProgressIndicator()):
                  /// future reload only one after add or delete make rfresh
                  //     FutureBuilder<List<Task>>(builder: (buildContext , snapshot){
                  //       //return widget
                  //       if(snapshot.connectionState == ConnectionState.waiting){
                  //         // future fun hasn't completed yet
                  //         return Center(child: CircularProgressIndicator());
                  //       }
                  //       if(snapshot.hasError){
                  //         return Center(child: Column(
                  //           children: [
                  //             Text('Error loading tasks ,' 'try again later'),
                  //
                  //             //Todo : show try again button y3ml reload
                  //           ],
                  //         ),);
                  //       }
                  //       var tasks = snapshot.data;
                  //       return  ListView.builder(
                  //         itemBuilder: (_, index) {
                  //           return TaskItem(tasks![index]);
                  //         },
                  //         itemCount: tasks?.length ?? 0 ,
                  //       );
                  //     } , future: MyDatabase.getTasks() ,)

                  ///another solution - realtime db

                  StreamBuilder<QuerySnapshot<Task>>(
            stream: MyDatabase.getTasksRealTimeUpdate(),
            builder: (buildContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Text('Error loading Tasks ,' 'try again later'),
                    ],
                  ),
                );
              }
              var tasks = snapshot.data?.docs.map((doc) => doc.data()).toList();
              return ListView.builder(
                itemBuilder: (_, index) {
                  return TaskItem(tasks![index]);
                },
                itemCount: tasks?.length ?? 0,
              );
            },
          )),
        ],
      ),
    );
  }

// void loadTask() async{
//   //call database to get task
//   //then reaload  widget to view tasks
//   allTasks = await MyDatabase.getTasks();
//   setState(() {
//
//   });
//
// }
}
