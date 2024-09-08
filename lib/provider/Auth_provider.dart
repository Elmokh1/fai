
import 'package:fai/database/model/customer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fai/database/model/report_model.dart';
import 'package:fai/database/model/task_model.dart';

import '../database/model/eng_model.dart';

class appProvider extends ChangeNotifier{
  EngModel ? currentUser;
  Task ? currentTask;
  Report ? currentReport;
  CustomerModel? customerModel;
  void updateUSer (EngModel loggedIn) {
    currentUser = loggedIn;
    notifyListeners();
  }
  void updateCustomer (CustomerModel loggedIn) {
    customerModel = loggedIn;
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
