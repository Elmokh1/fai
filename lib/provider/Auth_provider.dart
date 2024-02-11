
import 'package:flutter/cupertino.dart';
import 'package:fai/database/model/report_model.dart';
import 'package:fai/database/model/task_model.dart';

import '../database/model/user_model.dart';

class appProvider extends ChangeNotifier{
  UserModel ? currentUser;
  Task ? currentTask;
  Report ? currentReport;
  void updateUSer (UserModel loggedIn) {
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
