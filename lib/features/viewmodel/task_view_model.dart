import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/features/viewmodel/registration_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/TaskModel.dart';
import '../models/commentModel.dart';
import '../models/tasks.dart';
import '../presentation/theBloc/taskbloc/bloc/task_bloc.dart';
import 'package:intl/intl.dart';

class TaskViewModel {
  final String userIdd = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? taskid2;

  Future<Either<String, Tasks>> handleAddTaskEvent(AddTaskEvent event) async {
    final String taskId = uuid.v4();
    try {
      final DateTime now = DateTime.now();
      final String formattedDate =
          DateFormat.yMMMMd('en_US').add_Hm().format(now);
      final CollectionReference tasksCollection =
          _firestore.collection('users').doc(userIdd).collection('tasks');

      await tasksCollection.doc(taskId).set({
        'taskId': taskId,
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
          taskid2 = taskDoc.id;
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
      final DocumentReference taskDocRef = _firestore
          .collection('users')
          .doc(userIdd)
          .collection('tasks')
          .doc(taskId);

      final DocumentSnapshot taskDoc = await taskDocRef.get();
      if (!taskDoc.exists) {
        return left(
            'Permission denied: Only the creator of this task can delete it.'); // Task with the given ID doesn't exist
      }

      final Map<String, dynamic> taskData =
          taskDoc.data() as Map<String, dynamic>;

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

  Future<Either<String, String>> updateTaskStatus(
      String taskId, bool isDone) async {
    try {
      final DocumentReference taskDocRef = _firestore
          .collection('users')
          .doc(userIdd)
          .collection('tasks')
          .doc(taskId);

      final DocumentSnapshot taskDoc = await taskDocRef.get();
      if (!taskDoc.exists) {
        return left('Task not found'); // Task with the given ID doesn't exist
      }

      final Map<String, dynamic> taskData =
          taskDoc.data() as Map<String, dynamic>;

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

  Future<Either<String, Comment>> addCommentToTask(
      String commentId, Comment comment) async {
    try {
      final taskRef = _firestore;

      final commentsCollectionRef = taskRef.collection('comments');

      // Add the comment to the comments collection
      final addedCommentRef = await commentsCollectionRef.add(comment.toJson());
      final addedCommentDoc = await addedCommentRef.get();

      // Create a Comment object from the added comment data
      final addedComment = Comment(
        commentId: commentId,
        commentBody: addedCommentDoc['commentBody'],
        commenterId: addedCommentDoc['commenterId'],
        commenterName: addedCommentDoc['commenterName'],
        commenterImageUrl: addedCommentDoc['commenterImageUrl'],
      );

      return right(addedComment); // Pass the added comment to right() function
    } catch (e) {
      return left(
          'Error adding comment: $e'); // Use Dartz's left() function to indicate failure
    }
  }

  Future<Either<String, List<Comment>>> getCommentsForTask(
      String commentId) async {
    try {
      final commentsList =
          <Comment>[]; // Initialize an empty list to store comments

      // Reference to the task's comments collection
      final commentsCollectionRef = _firestore.collection('comments');

      // Get all comments from the comments collection where commentId is equal to taskDoc.id
      final querySnapshot = await commentsCollectionRef
          .where('commentId', isEqualTo: commentId)
          .get();

      // Convert the query snapshot to a list of Comment objects
      for (var doc in querySnapshot.docs) {
        final comment = Comment(
          commentId: doc.id,
          commentBody: doc['commentBody'],
          commenterId: doc['commenterId'],
          commenterName: doc['commenterName'],
          commenterImageUrl: doc['commenterImageUrl'],
        );
        commentsList.add(comment);
      }
      print('333333333333333333333333333333333333333333${commentId}');
      print('4444444444444444444444444444444444444444444${userIdd}');
      return right(
          commentsList); // Pass the list of comments to right() function
    } catch (e) {
      return left(
          'Error fetching comments: $e'); // Use Dartz's left() function to indicate failure
    }
  }
}
//to describe the cloud firestore i have 2 collections users inside it there is 
//documents that has fields one of them is commentId  and has a collection inside named tasks inside it alot
//of documents and  and also i have beside the users collection a comments on that have 
//documents i want if commentId == tasks id to fetch that comment