import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter/ui/home/taskList/task_item.dart';

class TaskListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              itemBuilder: (_, index) {
                return TaskItem();
              },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
