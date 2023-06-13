import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

enum ImportanceType { no, low, high }

class TodoEntity {
  String name;
  String description;
  bool completed;
  ImportanceType important;
  DateTime? deadline;
  bool hasDeadline;

  TodoEntity({
    this.name = '',
    this.description = '',
    this.completed = false,
    this.important = ImportanceType.no,
    this.deadline,
    this.hasDeadline = false,
  });

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    String description = json['description'];
    bool done = json['done'];
    ImportanceType importance = importanceFromString(json['importance']);
    DateTime? deadline =
        json['deadline'] != null ? DateTime.parse(json['deadline']) : null;
    bool hasDeadline = json['hasDeadline'];
    return TodoEntity(
      name: name,
      description: description,
      completed: done,
      important: importance,
      deadline: deadline,
      hasDeadline: hasDeadline,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'done': completed,
      'importance': importanceToString(important),
      'deadline': deadline?.toIso8601String(),
      'hasDeadline': hasDeadline,
    };
  }

  @override
  List<Object> get props => [
        name,
        description,
        completed,
        important,
        deadline ?? 'none',
        hasDeadline
      ];
}

String importanceToString(ImportanceType importance) {
  switch (importance) {
    case ImportanceType.low:
      return 'low';
    case ImportanceType.high:
      return 'high';
    default:
      return 'no';
  }
}

ImportanceType importanceFromString(String value) {
  switch (value) {
    case 'low':
      return ImportanceType.low;
    case 'high':
      return ImportanceType.high;
    default:
      return ImportanceType.no;
  }
}

extension Parser on ImportanceType {
  String get name {
    return toString().split('.').last;
  }
}

extension DateToText on DateTime {
  String get date {
    var formatter = DateFormat('d MMMM yyyy');
    return formatter.format(this);
  }
}
