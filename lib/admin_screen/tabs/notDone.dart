import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fai/admin_screen/tabs/Extract/extract_not_done_task.dart';
import 'package:fai/database/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../MyDateUtils.dart';
import '../../database/model/task_model.dart';
import '../../database/model/eng_model.dart';
import '../../database/my_database.dart';
import '../../ui/HomeScreen/todos_list/task_item.dart';

class NotDone extends StatefulWidget {
  CustomerModel user;

  NotDone(this.user);

  @override
  State<NotDone> createState() => _NotDoneState();
}

class _NotDoneState extends State<NotDone> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: focusedDate,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onFormatChanged: (format) => null,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDate = selectedDay;
                this.focusedDate = focusedDay;
              });
            },
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot<Task>>(
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
              if (taskList?.isEmpty == true) {
                return Center(
                  child: Text(
                    "لا توجد زيارات مقرره ",
                    style: GoogleFonts.abel(fontSize: 12, color: Colors.red),
                  ),
                );
              }

              int undoneTasksCount =
                  taskList!.where((task) => !task.isDone).length;
              int doneTasksCount = taskList.where((task) => task.isDone).length;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  child: Column(
                    children: [
                      Text(
                        'عدد الزيارات غير المنتهية: $undoneTasksCount',
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                      Text(
                        'عدد الزيارات المنتهية: $doneTasksCount',
                        style: TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              );
            },
            stream: MyDataBase.getTasksRealTimeUpdate(
              widget.user.id ?? "",
              MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExtractNotDoneTask(
                    day: selectedDate,
                    user: widget.user,
                  ),
                ),
              );
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text("استخراج خطوط السير"),
              ),
            ),
          ),
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
                if (taskList?.isEmpty == true) {
                  return Center(
                    child: Text(
                      "!! فاضي ",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final task = taskList![index];
                    if (task.isDone == true) {
                      return SizedBox
                          .shrink(); // إخفاء العنصر إذا كانت isDone = true
                    } else {
                      return TaskItem(task: task);
                    }
                  },
                  itemCount: taskList?.length ?? 0,
                );
              },
              stream: MyDataBase.getTasksRealTimeUpdate(
                widget.user.id ?? "",
                MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
