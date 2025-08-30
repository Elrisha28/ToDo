import 'package:equatable/equatable.dart';
import '../models/task.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  final bool loading;
  final String? error;

  const TaskState({
    this.tasks = const [],
    this.loading = false,
    this.error,
  });

  TaskState copyWith({
    List<Task>? tasks,
    bool? loading,
    String? error,
  }) =>
      TaskState(
        tasks: tasks ?? this.tasks,
        loading: loading ?? this.loading,
        error: error,
      );

  @override
  List<Object?> get props => [tasks, loading, error];
}
