import 'package:fai/ui/HomeScreen/add_task/added_task.dart';
import 'package:flutter/material.dart';

import '../../../MyDateUtils.dart';
import '../../../import.dart';
import 'addTaskBottomSheet.dart';

class AddNewTask extends StatefulWidget {
  static const routeName = "AddNewTask";

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var selectedDate = DateTime.now();
  bool showAddTaskBottom = false;
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  int tasksLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var taskList =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                tasksLength = taskList?.length ?? 0;
                if (taskList?.isEmpty == true) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/fai.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final task = taskList![index];
                    return AddedTask(
                      task: task,
                    );
                  },
                  itemCount: taskList?.length ?? 0,
                );
              },
              stream: MyDataBase.getTasksRealTimeUpdate(
                user?.uid ?? "",
                MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "عدد الزيارات ",
                  style: GoogleFonts.inter(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text("${tasksLength}"),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                showAddTaskBottom = true;
              });
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.all(5),
                child: Center(child: Text("Add New Client")),
                height: 50,
                width: 150,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Visibility(
            visible: showAddTaskBottom,
            child: Container(
              child: AddTaskBottomSheet(
                Time: selectedDate,
                toggleShowAddTaskBottom: _toggleShowAddTaskBottom,
              ),
            ),
          ),
          Spacer(),
          Container(
            width: 200,
            height: 100,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                Text(
                  "Selected time",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      showTaskDatePicker();
                    },
                    child: Text(
                      "${MyDateUtils.formatTaskDate(selectedDate)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleShowAddTaskBottom(bool value) {
    setState(() {
      showAddTaskBottom = value;
    });
  }

  void showTaskDatePicker() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 2)),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (date == null) return;
    setState(() {
      selectedDate = date;
    });
  }
}
