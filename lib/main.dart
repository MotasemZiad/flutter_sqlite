import 'package:flutter/material.dart';
import 'package:local_storage/database_helper.dart';
import 'package:local_storage/new_task.dart';
import 'package:local_storage/task_model.dart';
import 'package:local_storage/task_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // darkTheme: ThemeData.dark(),
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: TabBarPage(),
    );
  }
}

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'Incomplete Tasks',
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [AllTasks(), CompleteTasks(), INncompleteTasks()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 12,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return NewTask();
              },
            ));
          }),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: FutureBuilder<List>(
        future: DatabaseHelper.databaseHelper.selectAllTasks(),
        initialData: List(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data[position];
                    bool isComplete = false;
                    if (snapshot.data[position].row[2] == 1) {
                      isComplete = true;
                    } else {
                      isComplete = false;
                    }
                    return TaskWidget(Task(
                        taskName: snapshot.data[position].row[1],
                        isComplete: isComplete));
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  doRuntime() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: FutureBuilder<List>(
        future: DatabaseHelper.databaseHelper.selectCompleteTask(),
        initialData: List(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data[position];
                    bool isComplete = false;
                    if (snapshot.data[position].row[2] == 1) {
                      isComplete = true;
                    } else {
                      isComplete = false;
                    }
                    return TaskWidget(
                      Task(
                          taskName: snapshot.data[position].row[1],
                          isComplete: isComplete),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class INncompleteTasks extends StatefulWidget {
  @override
  _INncompleteTasksState createState() => _INncompleteTasksState();
}

class _INncompleteTasksState extends State<INncompleteTasks> {
  doRuntime() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: FutureBuilder<List>(
        future: DatabaseHelper.databaseHelper.selectInCompleteTask(),
        initialData: List(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data[position];
                    bool isComplete = false;
                    if (snapshot.data[position].row[2] == 1) {
                      isComplete = true;
                    } else {
                      isComplete = false;
                    }
                    return TaskWidget(
                      Task(
                          taskName: snapshot.data[position].row[1],
                          isComplete: isComplete),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
