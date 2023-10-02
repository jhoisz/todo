import '../entities/task.dart';

abstract class TaskUsecases {
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> removeTask(Task task);
  Future<List<Task>> getTasks();
}