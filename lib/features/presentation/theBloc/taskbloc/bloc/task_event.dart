part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Tasks tasks;

  const AddTaskEvent({
    required this.tasks,
  });

  @override
  List<Object> get props => [tasks];
}

class FetchTasksEvent extends TaskEvent {}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);
}

class UpdateTaskStatusEvent extends TaskEvent {
  final String taskId;
  final bool isDone;

  UpdateTaskStatusEvent({required this.taskId, required this.isDone});

  @override
  List<Object> get props => [taskId, isDone];
}
