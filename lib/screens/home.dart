import 'package:flutter/material.dart';
import 'package:todo/screens/components/no_tasks.dart';

import '../controllers/task_controller.dart';
import '../domain/entities/task.dart';
import '../themes/theme.dart';
import 'components/task_list.dart';
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
            'Minhas tarefas',
            style: ThemeStyle.titleStyle,
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () => dialogNewTask(context),
          elevation: 2.0,
          child: const Icon(
            Icons.add,
            color: AppColors.softBlue,
          ),
        ),
        backgroundColor: AppColors.background,
        body: FutureBuilder(
          future: _tasks,
          builder: (context, snapshot) {
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
                    return const Center(child: NoAllTasks());
                  }
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: Text(
                            'A fazer',
                            style: ThemeStyle.subTitleStyle,
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
                            'Feito',
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

  Future<String?> dialogNewTask(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Nova tarefa',
          textAlign: TextAlign.center,
          style: ThemeStyle.titleStyle,
        ),
        content: NewTask(
          updateTasks: (value) async {
            await taskController.addTask(value);
            refreshList();
          },
        ),
      ),
    );
  }
}

