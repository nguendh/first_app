import 'package:first_app/data/todo_table.dart';
import 'package:first_app/entity/todo_entity.dart';
import 'package:first_app/pages/todo_list_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

late Box box;
Future<void> main() async {
  box = Hive.box('todo');
  Hive.registerAdapter(TodoTableAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return TodoListPage(
      type: TaskType.all,
      todoList: [
        TodoEntity(
            id: 'id',
            title: 'title',
            completed: false,
            important: ImportantType.no)
      ],
    );
  }
}
