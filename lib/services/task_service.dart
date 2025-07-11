import '../models/task_model.dart';

class TaskService {
  final List<TaskModel> _tasks = [];

  List<TaskModel> getTasks() {
    return _tasks;
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
    print("Tâche ajoutée : ${task.title}");
  }

  void toggleComplete(String taskId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index] = TaskModel(
        id: _tasks[index].id,
        title: _tasks[index].title,
        description: _tasks[index].description,
        isCompleted: !_tasks[index].isCompleted,
        createdAt: _tasks[index].createdAt,
      );
    }
  }
}
