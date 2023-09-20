




import 'package:equatable/equatable.dart';
class Tasks extends Equatable {
  final String personId;
  final String taskCategory;
  final String taskTitle;
  final String taskDescription;
  final String taskDeadlineDate;

  Tasks({
    required this.personId,
    required this.taskCategory,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDeadlineDate,
  });

  @override
  List<Object?> get props => [
        personId,
        taskCategory,
        taskTitle,
        taskDescription,
        taskDeadlineDate,
      ];

}
