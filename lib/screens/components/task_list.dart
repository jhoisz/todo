import 'package:flutter/material.dart';

import '../../controllers/task_controller.dart';
import '../../domain/entities/priority.dart';
import '../../domain/entities/task.dart';
import '../../themes/theme.dart';
import 'no_tasks.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
    required this.tasks,
    required this.updateTask,
  });
  final List<Task> tasks;
  final Function(Task) updateTask;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final TaskController _taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    return widget.tasks.isNotEmpty
        ? SliverList.builder(
            itemCount: widget.tasks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Dismissible(
                  key: Key(widget.tasks[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    final Task task = Task(
                      id: widget.tasks[index].id,
                      title: widget.tasks[index].title,
                      description: widget.tasks[index].description,
                      priority: widget.tasks[index].priority,
                      isChecked: !widget.tasks[index].isChecked,
                    );

                    _taskController.removeTask(task);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tarefa apagada!'),
                      ),
                    );
                  },
                  background: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                      color: AppColors.deleteColor,
                    ),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: AppColors.softBlue,
                      ),
                    ),
                  ),
                  child: CheckboxListTile(
                    value: widget.tasks[index].isChecked,
                    onChanged: (value) async {
                      final Task task = Task(
                        id: widget.tasks[index].id,
                        title: widget.tasks[index].title,
                        description: widget.tasks[index].description,
                        priority: widget.tasks[index].priority,
                        isChecked: !widget.tasks[index].isChecked,
                      );
                      widget.updateTask(task);
                    },
                    title: Text(widget.tasks[index].title),
                    subtitle: const Text(
                      '12:00',
                      style: ThemeStyle.cardTimeText,
                    ),
                    secondary: Icon(
                      Icons.circle,
                      color: priorities[widget.tasks[index].priority],
                      size: 20.0,
                    ),
                    tileColor: AppColors.softBlue,
                    activeColor: AppColors.softBlue,
                    side: const BorderSide(
                      color: AppColors.primary,
                      width: 1.0,
                    ),
                    checkColor: AppColors.primary,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : const NoTasks();
  }
}
