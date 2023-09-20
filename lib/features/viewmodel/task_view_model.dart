import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/features/viewmodel/registration_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/taskmodel.dart';
import '../presentation/theBloc/taskbloc/bloc/task_bloc.dart';
import 'package:intl/intl.dart';


class TaskViewModel {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Either<String, Tasks>> handleAddTaskEvent(AddTaskEvent event) async {
    try {
final String taskId = uuid.v4();
      DateTime now = DateTime.now();
      String formattedDate = DateFormat.yMMMMd('en_US').add_Hm().format(now);
       final CollectionReference tasksCollection =
          _firestore.collection('users').doc(userId).collection('tasks');

      await tasksCollection.doc(taskId).set({
        'personId': userId,
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
}








// Query<Map<String, dynamic>> querySnapshot=await _firestore.collection('users').where("uid",isEqualTo:_auth.currentUser!.uid );