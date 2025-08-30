import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/task_repository.dart';
import '../models/task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc({required this.repository}) : super(const TaskState(loading: true)) {
    on<LoadTasks>(_onLoad);
    on<AddTask>(_onAdd);
    on<ToggleTask>(_onToggle);
    on<DeleteTask>(_onDelete);
  }

  Future<void> _onLoad(LoadTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final items = repository.getAll();
      emit(state.copyWith(tasks: items, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onAdd(AddTask event, Emitter<TaskState> emit) async {
    if (event.title.trim().isEmpty) return;
    final id = _randomId();
    final task = Task(id: id, title: event.title.trim());
    await repository.add(task);
    add(LoadTasks());
  }

  Future<void> _onToggle(ToggleTask event, Emitter<TaskState> emit) async {
    final current =
        state.tasks.firstWhere((t) => t.id == event.id, orElse: () => Task(id: '', title: ''));
    if (current.id.isEmpty) return;
    await repository.update(current.copyWith(isDone: !current.isDone));
    add(LoadTasks());
  }

  Future<void> _onDelete(DeleteTask event, Emitter<TaskState> emit) async {
    await repository.delete(event.id);
    add(LoadTasks());
  }

  String _randomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final r = Random.secure();
    return List.generate(12, (_) => chars[r.nextInt(chars.length)]).join();
  }
}
