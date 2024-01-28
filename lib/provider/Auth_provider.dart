
import 'package:flutter/cupertino.dart';
import 'package:fai/database/model/report_model.dart';
import 'package:fai/database/model/task_model.dart';

import '../database/model/user_model.dart';

class appProvider extends ChangeNotifier{
  User ? currentUser;
  Task ? currentTask;
  Report ? currentReport;
  void updateUSer (User loggedIn) {
    currentUser = loggedIn;
    notifyListeners();
  }
  void updateTask(Task task) {
    currentTask = task;
    notifyListeners();
  }
  void updateReport(Report report) {
    currentReport = report;
    notifyListeners();
  }
}
