import 'package:first_app/core/todo_database.dart';
import 'package:first_app/core/todo_entity.dart';
import 'package:first_app/core/todo_entity.dart';
import 'package:first_app/pages/todo_list_page.dart';
import 'package:flutter/material.dart';

class CreateTodoPage extends StatefulWidget {
  static const id = "add_edit_task_screen";

  final TodoEntity todo;
  final bool newTask;

  const CreateTodoPage({super.key, required this.todo, this.newTask = false});

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final bool _inSync = false;
  // Widget important = Text('Нет');
  Widget _selectedItem = Text('Нет');
  DateTime? deadline;
  bool showDate = false;

  late TextEditingController titleTextController;
  late TextEditingController descriptionTextController;
  final database = TodoDatabase();

  void _saveTask() {
    widget.todo.name = titleTextController.text;
    widget.todo.description = descriptionTextController.text;
  }

  @override
  void initState() {
    titleTextController = TextEditingController(text: widget.todo.name);
    descriptionTextController = TextEditingController(
      text: widget.todo.description,
    );
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: "",
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != deadline) {
      setState(() {
        deadline = picked;
      });
    }
  }

  ImportanceType toImportantType(Widget value) {
    if (value == Text("Нет")) return ImportanceType.no;
    if (value == Text("Низкий")) return ImportanceType.low;
    return ImportanceType.high;
  }

  String formatDateTime(DateTime dateTime) {
    final russianMonths = [
      '',
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];

    final day = dateTime.day.toString();
    final month = russianMonths[dateTime.month];
    final year = dateTime.year.toString();

    return '$day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Color(hexStringToHexInt('#F7F6F2')),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              !_inSync
                  ? TextButton(
                      onPressed: () async {
                        _saveTask();
                        database.addTask(widget.todo);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "СОХРАНИТЬ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.2,
                      ))
                  : const Icon(Icons.refresh),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: SizedBox(
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: 5,
                          minLines: 5,
                          controller: descriptionTextController,
                          decoration: InputDecoration(
                            hintText: 'Что надо делать...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    PopupMenuButton<Widget>(
                      onSelected: (Widget value) {
                        setState(
                          () {
                            _selectedItem = value;
                            widget.todo.important = toImportantType(value);
                          },
                        );
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<Widget>(
                            value: Text('Нет'),
                            child: Text('Нет'),
                          ),
                          const PopupMenuItem<Widget>(
                            value: Text('Низкий'),
                            child: Text('Низкий'),
                          ),
                          PopupMenuItem<Widget>(
                            value: Text('!! Высокий',
                                style: TextStyle(
                                    color:
                                        Color(hexStringToHexInt('#FF3B30')))),
                            child: Text('!! Высокий',
                                style: TextStyle(
                                    color:
                                        Color(hexStringToHexInt('#FF3B30')))),
                          ),
                        ];
                      },
                      child: ListTile(
                        title: const Text('Важность',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        subtitle: _selectedItem,
                        trailing: null,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SwitchListTile(
                      title: const Text(
                        'Сделать до',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      subtitle: widget.todo.hasDeadline
                          ? Text(
                              formatDateTime(deadline!),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(
                                  hexStringToHexInt('#248dfc'),
                                ),
                              ),
                            )
                          : null,
                      value: widget.todo.hasDeadline,
                      onChanged: (bool value) {
                        widget.todo.hasDeadline = value;
                        var currentDate = DateTime.now();
                        if (value) {
                          showDatePicker(
                            context: context,
                            initialDate: currentDate.add(
                              const Duration(days: 1),
                            ),
                            firstDate: currentDate,
                            lastDate: DateTime(2030),
                          ).then((value) {
                            widget.todo.deadline = value;
                            if (value == null) {
                              widget.todo.hasDeadline = false;
                            }
                            setState(() {});
                          });
                        } else {
                          widget.todo.deadline = null;
                          widget.todo.hasDeadline = false;
                        }
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 40.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: FloatingActionButton.extended(
                        label: Text('Удалять',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color(hexStringToHexInt('#FF3B30')))),
                        backgroundColor: Colors.white.withOpacity(1),

                        // <YOUR CODE HERE>
                        onPressed: widget.newTask
                            ? null
                            : () {
                                database.removeTask(widget.todo);
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                        elevation: 0.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        icon: Icon(
                          Icons.delete,
                          size: 24.0,
                          color: Color(hexStringToHexInt('#FF3B30')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
