import '../data/task_database.dart';
import '../domain/usecases/task_usecases.dart';
import '../domain/entities/task.dart';

class TaskController implements TaskUsecases {
  final TaskDatabase _taskDatabase = TaskDatabase();

  @override
  Future<void> addTask(Task task) async {
    await _taskDatabase.save(task);
  }

  @override
  Future<List<Task>> getTasks() async {
    return await _taskDatabase.findAll();
  }

  @override
  Future<void> removeTask(Task task) async {
    await _taskDatabase.delete(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _taskDatabase.save(task);
  }
}
