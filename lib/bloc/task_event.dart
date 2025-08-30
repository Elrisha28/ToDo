import 'package:equatable/equatable.dart';
import '../models/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  const AddTask(this.title);

  @override
  List<Object?> get props => [title];
}

class ToggleTask extends TaskEvent {
  final String id;
  const ToggleTask(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteTask extends TaskEvent {
  final String id;
  const DeleteTask(this.id);

  @override
  List<Object?> get props => [id];
}
