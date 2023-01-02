import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_flutter/database/task.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollection() {
    var tasksCollection = FirebaseFirestore.instance
        .collection('tasks')
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFireStore());

    return tasksCollection;
  }

  static Future insertTask(Task task) {
    var tasksCollection = getTasksCollection();
    //handele task id
    var doc = tasksCollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }
}
