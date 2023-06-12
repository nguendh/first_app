import 'package:first_app/entity/todo_entity.dart';
import 'package:first_app/pages/todo_list_page.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback? onUpdate;

  const TodoItem({Key? key, required this.todo, this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
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
        } else {
          /// Complete
        }
        return false;
      },
      child: ListTile(
        title: Text(
          todo.title,
          style: todo.completed
              ? Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(decoration: TextDecoration.lineThrough)
              : Theme.of(context).textTheme.bodyText1,
        ),
        leading: IconButton(
          onPressed: onUpdate,
          icon: Icon(
            todo.completed ? Icons.check_box : Icons.check_box_outline_blank,
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.info_outline,
          ),
        ),
      ),
    );
  }

  String makeTitle(TodoEntity todo) {
    if (todo.important == ImportantType.high) {
      // <YOUR CODE HERE>
      todo.title = todo.title;
    }
    if (todo.important == ImportantType.low) {
      // <YOUR CODE HERE>
      todo.title = todo.title;
    }
    return todo.title;
  }
}
