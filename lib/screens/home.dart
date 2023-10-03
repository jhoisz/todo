import 'package:flutter/material.dart';

import '../controllers/task_controller.dart';
import '../domain/entities/task.dart';
import '../themes/theme.dart';
import 'components/no_tasks.dart';
import 'new_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TaskController taskController = TaskController();

  Future<List<Task>>? _tasks;

  @override
  void initState() {
    _tasks = updateAndGetList();
    super.initState();
  }

  void refreshList() {
    setState(() {
      _tasks = updateAndGetList();
    });
  }

  Future<List<Task>> updateAndGetList() async {
    return taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My tasks',
            style: ThemeStyle.titleStyle,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewTask(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.background,
        body: FutureBuilder(
          future: _tasks,
          builder: (context, snapshot) {
            print('teste');
            final ConnectionState connectionState = snapshot.connectionState;
            final tasks = snapshot.data;
            switch (connectionState) {
              case ConnectionState.active:
                break;
              case ConnectionState.waiting:
              case ConnectionState.done:
                if (tasks == null || tasks.isEmpty) {
                  if (connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const NoTasks();
                  }
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 20.0,
                            ),
                            child: Text(
                              'To do',
                              style: ThemeStyle.subTitleStyle,
                            ),
                          ),
                        ),
                        TasksList(
                          tasks: tasks
                              .where((task) => task.isChecked == false)
                              .toList(),
                          updateTask: (value) async {
                            await taskController.addTask(value);
                            refreshList();
                          },
                        ),
                        const SliverToBoxAdapter(
                          child: Text(
                            'Done',
                            style: ThemeStyle.subTitleStyle,
                          ),
                        ),
                        TasksList(
                          tasks: tasks
                              .where((task) => task.isChecked == true)
                              .toList(),
                          updateTask: (value) async {
                            await taskController.addTask(value);
                            refreshList();
                          },
                        ),
                      ],
                    ),
                  );
                }
              case ConnectionState.none:
                break;
              default:
                return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
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
          secondary: const Icon(
            Icons.circle,
            color: AppColors.lowPriority,
            size: 20.0,
          ),
          tileColor: Colors.white,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
        );
      },
    );
  }
}
