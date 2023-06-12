import '../entity/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required String id,
    required String title,
    required bool completed,
    required ImportantType important,
    DateTime? deadline,
  }) : super(
          id: id,
          title: title,
          completed: completed,
          important: important,
          deadline: deadline,
        );

  factory TodoModel.fromJson(dynamic json) => TodoModel(
      id: json['_id'],
      title: json['title'],
      completed: json['completed'] ?? false,
      important: json['important'],
      deadline: json['deadline']);

  static List<TodoModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => TodoModel.fromJson(json)).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['completed'] = completed;
    json['title'] = title;
    json['important'] = important;
    json['deadline'] = deadline;
    return json;
  }

  TodoModel.castFromEntity(final TodoEntity todo)
      : super(
          id: todo.id,
          title: todo.title,
          completed: todo.completed,
          important: todo.important,
          deadline: todo.deadline,
        );
}
