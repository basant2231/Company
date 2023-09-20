part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Tasks tasks;

  AddTaskEvent({
    required this.tasks,
  });

  @override
  List<Object> get props => [tasks];
}
