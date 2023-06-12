import 'package:flutter/material.dart';

import '../entity/todo_entity.dart';
import '../widgets/todo_item.dart';
// import 'create_todo_page.dart';

enum TaskType { all, inComplete, completed }

class TodoListPage extends StatefulWidget {
  static const String route = '/TodoListPage';

  const TodoListPage({Key? key, required this.type, required this.todoList})
      : super(key: key);

  final TaskType type;
  final List<TodoEntity> todoList;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            expandedHeight: 120.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('МОИ ДЕЛА'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Row(
                children: const [
                  Center(
                    child: Text('Выполнено - 5'),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return TodoItem(todo: widget.todoList[index]);
              },
              childCount: widget.todoList.length,
            ),
          ),
        ],
      ),
    );
  }

  List<TodoEntity> getTodos() {
    List<TodoEntity> list = [];
    if (widget.type == TaskType.completed) {
      list = widget.todoList.where((i) => i.completed).toList();
    } else if (widget.type == TaskType.inComplete) {
      list = widget.todoList.where((i) => !i.completed).toList();
    } else {
      list = widget.todoList;
    }
    return list;
  }
}
