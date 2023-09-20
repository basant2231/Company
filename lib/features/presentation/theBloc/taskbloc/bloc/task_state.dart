part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState();
  
  @override
  List<Object> get props => [];
}

 class TaskInitial extends TaskState {}
class TaskAddedSuccessState extends TaskState {
 final  Tasks tasks;
  TaskAddedSuccessState({
    required this.tasks,
  });
  
}
class TaskAddedLoadingState extends TaskState {}

class TaskAddedFailureState extends TaskState {
  final String error;

  TaskAddedFailureState({required this.error});
}