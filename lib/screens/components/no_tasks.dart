import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 36.0),
        child: const Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.primary,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Não existem tarefas aqui ainda',
                style: ThemeStyle.warningText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
