import 'package:flutter/material.dart';

import '../controllers/task_controller.dart';
import '../domain/entities/task.dart';
import '../themes/theme.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String dropdownValue = 'Normal';

  final _formKey = GlobalKey<FormState>();
  final TaskController _taskController = TaskController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                final Task task = Task(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  priority: dropdownValue,
                  isChecked: false,
                );
                _taskController.addTask(task);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tarefa salva!')),
                );
              }
            },
            child: Ink(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.32),
                    blurRadius: 5.0,
                    offset: const Offset(2, 2),
                  )
                ],
              ),
              child: const Center(
                child: Text(
                  'Salvar tarefa',
                  style: ThemeStyle.buttonText,
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Criar nova tarefa',
            style: ThemeStyle.titleStyle,
          ),
          centerTitle: true,
        ),
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  'Título',
                  style: ThemeStyle.subTitleStyle,
                ),
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Insira um título',
                    contentPadding: EdgeInsets.all(8.0),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Descrição',
                    style: ThemeStyle.subTitleStyle,
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Insira uma descrição',
                    contentPadding: EdgeInsets.all(8.0),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Prioridade',
                    style: ThemeStyle.subTitleStyle,
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.primary,
                  ),
                  elevation: 16,
                  isExpanded: true,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: ['Baixa', 'Normal', 'Alta']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
