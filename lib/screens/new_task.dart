import 'package:flutter/material.dart';

import '../domain/entities/task.dart';
import '../themes/theme.dart';
import 'components/custom_button.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.updateTasks});
  final Function(Task) updateTasks;

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String dropdownValue = 'Normal';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
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
                fillColor: AppColors.background,
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
                fillColor: AppColors.background,
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
              borderRadius: BorderRadius.circular(12.0),
              dropdownColor: Colors.white,
              items: ['Baixa', 'Normal', 'Alta'].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            CustomButton(
              colorButton: AppColors.primary,
              title: 'Salvar tarefa',
              action: () {
                if (_formKey.currentState!.validate()) {
                  addingTask(context);
                }
              },
            ),
            CustomButton(
              title: 'Sair',
              colorButton: AppColors.cancelButton,
              action: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void addingTask(BuildContext context) {
    final Task task = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      priority: dropdownValue,
      isChecked: false,
    );
    widget.updateTasks(task);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tarefa salva!'),
      ),
    );
  }
}

