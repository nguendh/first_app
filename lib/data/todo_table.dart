import 'package:hive/hive.dart';

import '../../../models/todo_model.dart';
import '../entity/todo_entity.dart';

part 'todo_table.g.dart';

class HiveTypeIdConstants {
  static const int customerTableId = 1;
}

class HiveTableNameConstants {
  static const todoTableName = 'todo';
}

@HiveType(typeId: HiveTypeIdConstants.customerTableId)
class TodoTable extends TodoModel {
  @override
  @HiveField(1)
  String id;

  @override
  @HiveField(2)
  String title;

  @override
  @HiveField(3)
  bool completed;

  @override
  @HiveField(4)
  ImportantType important;

  @override
  @HiveField(5)
  DateTime? deadline;

  TodoTable({
    required this.id,
    required this.title,
    required this.completed,
    required this.important,
    this.deadline,
  }) : super(
          id: id,
          title: title,
          completed: completed,
          important: important,
          deadline: deadline,
        );

  factory TodoTable.fromModel(TodoModel model) => TodoTable(
        id: model.id,
        title: model.title,
        completed: model.completed,
        important: model.important,
        deadline: model.deadline,
      );

  static TodoModel toModel(TodoTable table) => TodoModel(
        id: table.id,
        title: table.title,
        completed: table.completed,
        important: table.important,
        deadline: table.deadline,
      );
}
