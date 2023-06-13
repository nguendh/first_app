import 'package:first_app/core/todo_database.dart';
import 'package:first_app/main.dart';
import 'package:first_app/pages/create_todo_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/todo_entity.dart';
import '../widgets/todo_item.dart';
// import 'create_todo_page.dart';

enum TaskType { all, inComplete, completed }

class TodoListPage extends StatefulWidget {
  static const String route = '/TodoListPage';

  final SharedPreferences prefs;

  const TodoListPage({Key? key, required this.prefs}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  final database = TodoDatabase();
  late bool _showCompleteTasks;
  late List<TodoEntity> tasks;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _showCompleteTasks = widget.prefs.getBool('show_completed_tasks') ?? true;
    tasks = _showCompleteTasks ? database.tasks : database.uncompletedTasks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 120.0,
            pinned: true,
            backgroundColor: Color(hexStringToHexInt('#F7F6F2')),
            actions: [
              IconButton(
                onPressed: () {
                  // <YOUR CODE HERE>
                  setState(
                    () {
                      _showCompleteTasks = !_showCompleteTasks;
                      widget.prefs.setBool(
                        'show_completed_tasks',
                        _showCompleteTasks,
                      );
                      if (_showCompleteTasks) {
                        tasks = database.tasks;
                      } else {
                        tasks = database.uncompletedTasks;
                      }
                    },
                  );
                },
                icon: Icon(
                  _showCompleteTasks ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blue,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: EdgeInsets.only(
                    bottom: _scrollPosition == 0 ? 18 : 0,
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'МОИ ДЕЛА',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                background: Padding(
                  padding: const EdgeInsets.only(left: 73, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Выполнено - ${database.completed}',
                        style: TextStyle(
                          color: Color(
                            hexStringToHexInt('#D1D1D6'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          const SliverToBoxAdapter(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return TodoItem(
                  todo: tasks[index],
                );
              },
              childCount: tasks.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final _ = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return CreateTodoPage(todo: TodoEntity(), newTask: true);
            }),
          );
          setState(() {});
        },
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

int hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}
