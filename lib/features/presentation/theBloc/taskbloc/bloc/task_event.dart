part of 'task_bloc.dart';

 class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent{
  Tasks tasks;
  AddTaskEvent({
    required this.tasks,
  });
}
