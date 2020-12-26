import 'package:local_storage/database_helper.dart';

class Task {
  int id;
  String taskName;
  bool isComplete;
  Task({this.id, this.taskName, this.isComplete});
  toJson() {
    return {
      DatabaseHelper.taskIDColumnName: this.id,
      DatabaseHelper.taskNameColumnName: this.taskName,
      DatabaseHelper.taskIsCompleteColumnName: this.isComplete ? 1 : 0
    };
  }
}
