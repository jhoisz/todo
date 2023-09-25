// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  int? id;
  String title;
  String description;
  String priority;
  Task({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      priority: map['priority'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, priority: $priority)';
  }
}
