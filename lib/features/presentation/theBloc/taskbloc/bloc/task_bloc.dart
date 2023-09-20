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
    on<TaskEvent>(_handleAddTaskEvent);
  }

  void _handleAddTaskEvent(TaskEvent event, Emitter<TaskState> emit) async {
    if (event is AddTaskEvent) { // Check if the event is of type AddTaskEvent
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
}
