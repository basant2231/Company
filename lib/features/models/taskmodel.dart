class TaskModel {
  final String taskId;
  final String taskTitle;
  final String taskDescription;
  final String authorName;
  final String authorPosition;
  final String taskCategory;
  final String taskDeadlineDate;
  final String taskImage;
  final String taskBeginningDate;
  final bool isDone;

  TaskModel({
    required this.taskId,
    required this.taskBeginningDate,
    required this.taskTitle,
    required this.taskDescription,
    required this.authorName,
    required this.authorPosition,
    required this.taskCategory,
    required this.taskDeadlineDate,
    required this.taskImage,
    required this.isDone,
    
  });
}
