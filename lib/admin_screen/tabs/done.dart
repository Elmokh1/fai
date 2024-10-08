import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fai/database/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fai/ui/UserMap/user_map.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../MyDateUtils.dart';
import '../../database/model/income_model.dart';
import '../../database/model/target_model.dart';
import '../../database/model/task_model.dart';
import '../../database/model/eng_model.dart';
import '../../database/my_database.dart';
import '../../ui/HomeScreen/todos_list/task_item.dart';

class ReportDone extends StatefulWidget {
  CustomerModel user;

  ReportDone(this.user);

  @override
  State<ReportDone> createState() => _NotDoneState();
}

class _NotDoneState extends State<ReportDone> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  Set<Marker> markerSet = {};

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
          InkWell(
            onLongPress: () async {
              setState(() {});
              await MyDataBase.deleteTarget(widget.user!.id ?? "");
              await MyDataBase.deleteIncome(widget.user!.id ?? "");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot<Target>>(
                      builder: (context, targetSnapshot) {
                        if (targetSnapshot.hasError) {
                          return Container();
                        }
                        if (targetSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var targetList = targetSnapshot.data?.docs
                            .map((doc) => doc.data() as Target)
                            .toList();
                        double totalTarget = 0.0;
                        if (targetList != null && targetList.isNotEmpty) {
                          totalTarget = targetList
                              .map((target) => target.DailyTarget ?? 0)
                              .reduce((a, b) => a + b);
                        }

                        return StreamBuilder<QuerySnapshot<Income>>(
                          builder: (context, incomeSnapshot) {
                            if (incomeSnapshot.hasError) {
                              return Container();
                            }
                            if (incomeSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            var incomeList = incomeSnapshot.data?.docs
                                .map((doc) => doc.data() as Income)
                                .toList();
                            double totalIncome = 0.0;
                            if (incomeList != null && incomeList.isNotEmpty) {
                              totalIncome = incomeList
                                  .map((income) => income.DailyInCome ?? 0)
                                  .reduce((a, b) => a + b);
                            }
                            double difference = totalTarget - totalIncome;
                            return Column(
                              children: [
                                Text(
                                  'المستهدف: $totalTarget',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  'التحصيل الكلي: $totalIncome',
                                  style: TextStyle(color: Colors.black),
                                ),
                                StreamBuilder<QuerySnapshot<Income>>(
                                  builder: (context, incomeSnapshot) {
                                    if (incomeSnapshot.hasError) {
                                      return Container();
                                    }
                                    if (incomeSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    var incomeList = incomeSnapshot.data?.docs
                                        .map((doc) => doc.data() as Income)
                                        .toList();
                                    double totalIncome = 0.0;
                                    if (incomeList != null &&
                                        incomeList.isNotEmpty) {
                                      totalIncome = incomeList
                                          .map((income) =>
                                              income.DailyInCome ?? 0)
                                          .reduce((a, b) => a + b);
                                    }

                                    return InkWell(
                                      onTap: () {
                                        print(
                                          MyDateUtils.dateOnly(selectedDate)
                                              .millisecondsSinceEpoch,
                                        );
                                      },
                                      child: Text(
                                        "التحصيل اليومي : $totalIncome",
                                        style: GoogleFonts.inter(
                                          color: Colors.blue.withOpacity(.9),
                                        ),
                                      ),
                                    );
                                  },
                                  stream:
                                      MyDataBase.getDailyIncomeRealTimeUpdate(
                                    widget.user!.id ?? "",
                                    DateTime.fromMillisecondsSinceEpoch(
                                        MyDateUtils.dateOnly(selectedDate)
                                            .millisecondsSinceEpoch),
                                  ),
                                ),
                              ],
                            );
                          },
                          stream: MyDataBase.getIncomeRealTimeUpdate(
                              widget.user!.id ?? ""),
                        );
                      },
                      stream: MyDataBase.getTargetRealTimeUpdate(
                          widget.user!.id ?? ""),
                    ),
                  ],
                ),
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
                    if (task.isDone == false) {
                      return SizedBox.shrink();
                    } else {
                      return InkWell(
                        child: TaskItem(
                          task: task,
                          CustomerID: widget.user.id,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapTRACKUser(
                                task: task,
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                      );
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
