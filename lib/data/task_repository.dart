import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskRepository {
  static const tasksBoxName = 'tasks';

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    await Hive.openBox<Task>(tasksBoxName);
  }

  Box<Task> get _box => Hive.box<Task>(tasksBoxName);

  List<Task> getAll() {
    return _box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> add(Task task) async {
    await _box.put(task.id, task);
  }

  Future<void> update(Task task) async {
    await _box.put(task.id, task);
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  bool exists(String id) => _box.containsKey(id);
}
