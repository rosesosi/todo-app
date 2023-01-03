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

  // future 3shan mstnya result 3amla await
  static Future<List<Task>> getTasks() async {
    var querySnapshot = await getTasksCollection().get();
    // a7wl mn list of querysnapshot l list of task ast5dm map
    var tasksList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return tasksList;
  }

  static Future<QuerySnapshot<Task>> getTasksFuture() {
    return getTasksCollection().get();
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdate() {
    return getTasksCollection().snapshots();
  }

  static Future<void> deleteTask(Task task) {
    var taskDoc = getTasksCollection().doc(task.id);
    return taskDoc.delete();
  }
}
