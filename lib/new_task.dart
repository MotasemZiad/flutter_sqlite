import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/database_helper.dart';
import 'package:local_storage/task_model.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String name;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Enter your Task name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
              onChanged: (value) {
                this.name = value;
              },
            ),
            Checkbox(
                value: isComplete,
                onChanged: (value) {
                  this.isComplete = value;
                  setState(() {});
                }),
            RaisedButton(
                elevation: 6,
                child: Text(
                  'Add new Task',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepPurple,
                onPressed: () {
                  DatabaseHelper.databaseHelper.insertNewTask(
                      Task(taskName: name, isComplete: isComplete));
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
