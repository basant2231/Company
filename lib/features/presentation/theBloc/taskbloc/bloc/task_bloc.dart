import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../models/taskmodel.dart';
import '../../../../viewmodel/task_view_model.dart';

part 'task_event.dart';
part 'task_state.dart';
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskViewModel _taskViewModel = TaskViewModel();

  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>(_handleAddTaskEvent);
  }

  void _handleAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskAddedLoadingState());
    final result = await _taskViewModel.handleAddTaskEvent(event);

    result.fold(
      (error) {
        emit(TaskAddedFailureState(error: error));
      },
      (tasks) {
        emit(TaskAddedSuccessState(tasks: tasks));
      },
    );
  }
}
