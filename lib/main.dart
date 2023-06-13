import 'package:dynamic_color/dynamic_color.dart';
import 'package:first_app/core/todo_entity.dart';
import 'package:first_app/pages/todo_list_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_app/core/todo_database.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TodoDatabase database = TodoDatabase();
  await database.loadTasks();

  // TODO: Make usage of shared preferences more convenient
  final prefs = await SharedPreferences.getInstance();

  runApp(
    EasyDynamicThemeWidget(
      child: TodoListApp(prefs: prefs),
    ),
  );
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: TodoListPage(prefs: prefs),
    );
  }
}
