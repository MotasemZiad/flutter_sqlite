import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/database_helper.dart';
import 'package:local_storage/task_model.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  Function function;
  TaskWidget(this.task, [this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 6, left: 6, bottom: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  _alertDialog(context);
                  setState(() {});
                }),
            Text(widget.task.taskName),
            Checkbox(
                value: widget.task.isComplete,
                onChanged: (value) {
                  DatabaseHelper.databaseHelper.updateTask(this.widget.task);
                  this.widget.task.isComplete = !this.widget.task.isComplete;
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _alertDialog(BuildContext context) {
    final alertDialog = AlertDialog(
      title: Text('Alert'),
      content: Text('Do you really want ot delete this item?'),
      actions: [
        FlatButton(
            onPressed: () {
              DatabaseHelper.databaseHelper.deleteTask(Task(
                  taskName: widget.task.taskName,
                  isComplete: widget.task.isComplete));
              Navigator.pop(context);
              _showSnackBar(context, 'Task deleted successfully');
            },
            child: Text('Yes')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No')),
      ],
      elevation: 6,
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog,
    );
  }
}
