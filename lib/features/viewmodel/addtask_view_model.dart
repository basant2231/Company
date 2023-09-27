

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/taskmodel.dart';

class AddTaskViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getAllUserFullNames() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await _firestore.collection('users').get();

      final List<String> fullNames = [];

      for (final QueryDocumentSnapshot<Map<String, dynamic>> user
          in usersSnapshot.docs) {
        final fullName = user.get('fullName');
        if (fullName != null && fullName is String) {
          fullNames.add(fullName);
        }
      }

      return fullNames;
    } catch (e) {
      print('Error fetching user full names: $e');
      return [];
    }
  }

  Future<List<Tasks>> getAllTasksForUser(String personId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> tasksSnapshot = await _firestore
          .collection('users')
          .doc(personId)
          .collection('tasks')
          .get();

      final List<Tasks> tasks = [];

      for (final QueryDocumentSnapshot<Map<String, dynamic>> task
          in tasksSnapshot.docs) {
        final taskCategory = task.get('taskCategory');
        final taskTitle = task.get('taskTitle');
        final taskDescription = task.get('taskDescription');
        final taskDeadlineDate = task.get('taskDeadlineDate');

        if (taskCategory != null &&
            taskCategory is String &&
            taskTitle != null &&
            taskTitle is String &&
            taskDescription != null &&
            taskDescription is String &&
            taskDeadlineDate != null &&
            taskDeadlineDate is String) {
          tasks.add(Tasks(
            personId: personId,
            taskCategory: taskCategory,
            taskTitle: taskTitle,
            taskDescription: taskDescription,
            taskDeadlineDate: taskDeadlineDate,
          ));
        }
      }

      return tasks;
    } catch (e) {
      print('Error fetching tasks for user $personId: $e');
      return [];
    }
  }
}
