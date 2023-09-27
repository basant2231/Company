import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/features/viewmodel/registration_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/taskmodel.dart';
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
      final String formattedDate = DateFormat.yMMMMd('en_US').add_Hm().format(now);
      final CollectionReference tasksCollection = _firestore.collection('users').doc(userIdd).collection('tasks');

      await tasksCollection.doc(taskId).set({
        'personId': userIdd,
        'taskCategory': event.tasks.taskCategory,
        'taskTitle': event.tasks.taskTitle,
        'taskDescription': event.tasks.taskDescription,
        'taskDeadlineDate': event.tasks.taskDeadlineDate,
        'taskBeginningDate': formattedDate,
      });

      final taskModel = event.tasks;
      return right(taskModel);
    } catch (e) {
      return left('Task Addition Error: $e');
    }
  }

Future<Either<String, List<Tasks>>> fetchTasksFromFirebase() async {
  try {
    final User? user = _auth.currentUser;

    if (user != null) {
      final QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .get();

      final List<Tasks> tasksList = [];

      for (final userDoc in userSnapshot.docs) {
        final QuerySnapshot taskSnapshot = await userDoc
            .reference
            .collection('tasks')
            .get();

        tasksList.addAll(
          taskSnapshot.docs.map((doc) => Tasks.fromJson(doc.data() as Map<String, dynamic>)),
        );
      }

      return right(tasksList);
    } else {
      return left('User not authenticated.');
    }
  } catch (e) {
    return left('Firebase Fetch Error: $e');
  }
}
//i want also to go to every user user and go to every document and to get information fullName imagePath phoneNumber position
  Future<Either<String, bool>> deleteTaskFromFirebase(String taskId) async {
    try {
      final User? user = _auth.currentUser;

      if (user != null) {
        final DocumentReference taskRef = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('tasks')
            .doc(taskId);

        final DocumentSnapshot taskSnapshot = await taskRef.get();

        if (taskSnapshot.exists) {
          await taskRef.delete();
          return right(true); // Deletion was successful
        } else {
          return left('Task does not exist.');
        }
      } else {
        return left('User not authenticated.');
      }
    } catch (e) {
      return left('Firebase Delete Error: $e');
    }
  }
}







// Query<Map<String, dynamic>> querySnapshot=await _firestore.collection('users').where("uid",isEqualTo:_auth.currentUser!.uid );