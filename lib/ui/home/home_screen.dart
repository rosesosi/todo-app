import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app_flutter/ui/home/settings/settings_tab.dart';
import 'package:todo_app_flutter/ui/home/taskList/add_task.dart';
import 'package:todo_app_flutter/ui/home/taskList/task_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndexTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.projectName),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        child: Icon(Icons.add),
        onPressed: () {
          showAddTaskBottomSheet();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndexTab,
          onTap: (index) {
            setState(() {
              selectedIndexTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
      body: tabs[selectedIndexTab],
    );
  }

  var tabs = [TaskListTab(), SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return AddTask();
        });
  }
}
