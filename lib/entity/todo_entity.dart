import 'package:equatable/equatable.dart';

enum ImportantType { no, low, high }

class TodoEntity extends Equatable {
  String id;
  String title;
  bool completed;
  ImportantType important;
  DateTime? deadline;

  TodoEntity({
    required this.id,
    required this.title,
    required this.completed,
    required this.important,
    this.deadline,
  });

  @override
  List<Object> get props =>
      [id, title, completed, important, deadline ?? 'none'];
}
