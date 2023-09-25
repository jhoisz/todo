import 'package:flutter/material.dart';

 enum Priority {
  low(label: 'Baixa', color: Colors.green),
  normal(label: 'Média', color: Colors.blue),
  high(label: 'Alta', color: Colors.red);

  final String label;
  final Color color;

  const Priority({required this.label, required this.color});
}