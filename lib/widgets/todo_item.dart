import 'package:first_app/core/todo_database.dart';
import 'package:first_app/core/todo_entity.dart';
import 'package:first_app/pages/todo_list_page.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final TodoEntity todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final database = TodoDatabase();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.todo.name),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      background: Container(
        color: Colors.green,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          /// Delete
          setState(
            () {
              database.removeTask(widget.todo);
            },
          );
        } else {
          /// Complete
          setState(
            () {
              database.modifyTask(widget.todo, completed: true);
            },
          );
        }
        return false;
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: ListTile(
          title: Text(
            widget.todo.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          // if (todo.hasDeadline) {
          //   subtitle: todo.hasDeadline ? Text(todo.deadline!.date) }
          //    ,
          leading: Checkbox(
            value: widget.todo.completed,
            onChanged: (bool? value) {
              setState(() {
                database.modifyTask(widget.todo, completed: value);
              });
            },
          ),
          trailing: IconButton(
            onPressed: () async {
              // final _ = await Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return CreateTodoPage(todo: widget.todo);
              //     },
              //   ),
              // );
            },
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ),
      ),
    );
  }

  String makeTitle(TodoEntity todo) {
    if (todo.important == ImportanceType.high) {
      // <YOUR CODE HERE>
      todo.description = todo.description;
    }
    if (todo.important == ImportanceType.low) {
      // <YOUR CODE HERE>
      todo.description = todo.description;
    }
    return todo.description;
  }
}
