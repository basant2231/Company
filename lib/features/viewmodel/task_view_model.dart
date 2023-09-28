import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/features/viewmodel/registration_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/TaskModel.dart';
import '../models/tasks.dart';
import '../presentation/theBloc/taskbloc/bloc/task_bloc.dart';
import 'package:intl/intl.dart';

class TaskViewModel {
  final String userIdd = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<String, Tasks>> handleAddTaskEvent(AddTaskEvent event) async {
    try {
      final String taskId = uuid.v4();
      final DateTime now = DateTime.now();
      final String formattedDate =
          DateFormat.yMMMMd('en_US').add_Hm().format(now);
      final CollectionReference tasksCollection =
          _firestore.collection('users').doc(userIdd).collection('tasks');

      await tasksCollection.doc(taskId).set({
        'personId': userIdd,
        'taskCategory': event.tasks.taskCategory,
        'taskTitle': event.tasks.taskTitle,
        'taskDescription': event.tasks.taskDescription,
        'taskDeadlineDate': event.tasks.taskDeadlineDate,
        'taskBeginningDate': formattedDate,
        'isDone': false, // Set the initial value of isDone to false
      });

      final taskModel = event.tasks;
      return right(taskModel);
    } catch (e) {
      return left('Task Addition Error: $e');
    }
  }

  Future<List<TaskModel>> fetchTasks() async {
    try {
      final querySnapshotUsers = await _firestore.collection('users').get();

      final List<TaskModel> tasks = [];

      for (final userDoc in querySnapshotUsers.docs) {
        final userData = userDoc.data();
        final userId = userData['uid'];
        final imagePath = userData['imagePath']; // Retrieve imagePath here

        final tasksQuerySnapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .get();

        for (final taskDoc in tasksQuerySnapshot.docs) {
          final taskData = taskDoc.data();

          final task = TaskModel(
            taskId: taskDoc.id,
            taskTitle: taskData['taskTitle'] ?? '',
            taskDescription: taskData['taskDescription'] ?? '',
            authorName: userData['fullName'] ?? '',
            authorPosition: userData['position'] ?? '',
            taskCategory: taskData['taskCategory'] ?? '',
            taskDeadlineDate: taskData['taskDeadlineDate'] ?? '',
            taskImage: imagePath ?? '', // Use imagePath from userData
            isDone: taskData['isDone'] ?? false,
            taskBeginningDate: taskData['taskBeginningDate'] ??
                '', // Retrieve taskBeginningDate
          );

          tasks.add(task);
        }
      }

      return tasks;
    } catch (e) {
      print('Error fetching tasks: $e');
      throw e.toString();
    }
  }

 Future<Either<String, String>> deleteTask(String taskId) async {
    try {
      final DocumentReference taskDocRef =
          _firestore.collection('users').doc(userIdd).collection('tasks').doc(taskId);

      final DocumentSnapshot taskDoc = await taskDocRef.get();
      if (!taskDoc.exists) {
        return left('Permission denied: Only the creator of this task can delete it.'); // Task with the given ID doesn't exist
      }

      final Map<String, dynamic> taskData = taskDoc.data() as Map<String, dynamic>;

      // Check if the current user is the owner of the task
      if (taskData['personId'] == userIdd) {
        // User is the owner, allow deletion
        await taskDocRef.delete();
        return right('Task deleted successfully');
      } else {
        // User is not the owner, do not allow deletion
        return left('Permission denied: You cannot delete this task');
      }
    } catch (e) {
      return left('Task Deletion Error: $e');
    }
  }

  Future<Either<String, String>> updateTaskStatus(String taskId, bool isDone) async {
  try {
    final DocumentReference taskDocRef = _firestore.collection('users').doc(userIdd).collection('tasks').doc(taskId);

    final DocumentSnapshot taskDoc = await taskDocRef.get();
    if (!taskDoc.exists) {
      return left('Task not found'); // Task with the given ID doesn't exist
    }

    final Map<String, dynamic> taskData = taskDoc.data() as Map<String, dynamic>;

    // Check if the current user is the owner of the task
    if (taskData['personId'] == userIdd) {
      // User is the owner, update the isDone field
      await taskDocRef.update({'isDone': isDone});
      return right('Task status updated successfully');
    } else {
      // User is not the owner, do not allow the update
      return left('Permission denied: You cannot update the task status');
    }
  } catch (e) {
    return left('Task Status Update Error: $e');
  }
}
}