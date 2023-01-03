import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_flutter/database/task.dart';
import 'package:todo_app_flutter/utils/date_utils.dart';

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
    task.dateTime = task.dateTime.extractDateOnly();
    return doc.set(task);
  }

  // future 3shan mstnya result 3amla await
  static Future<List<Task>> getTasks(DateTime dateTime) async {
    var querySnapshot = await getTasksCollection()
        .where('dateTime',
            isEqualTo: dateTime.extractDateOnly().millisecondsSinceEpoch)
        .get();
    // a7wl mn list of querysnapshot l list of task ast5dm map
    var tasksList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return tasksList;
  }

  static Future<QuerySnapshot<Task>> getTasksFuture(DateTime dateTime) {
    return getTasksCollection()
        .where('dateTime',
            isEqualTo: dateTime.extractDateOnly().millisecondsSinceEpoch)
        .get();
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdate(DateTime dateTime) {
    return getTasksCollection()
        .where('dateTime',
            isEqualTo: dateTime.extractDateOnly().millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(Task task) {
    var taskDoc = getTasksCollection().doc(task.id);
    return taskDoc.delete();
  }
}
