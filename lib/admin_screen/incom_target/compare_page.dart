import 'package:fai/admin_screen/incom_target/compare_item_widget.dart';
import 'package:fai/database/model/customer_model.dart';
import 'package:fai/database/model/eng_model.dart';

import '../../import.dart';

class ComparePage extends StatelessWidget {
  CustomerModel user;

  ComparePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              "Eng ${user.name}",
              style: GoogleFonts.inter(fontSize: 30, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(),
          const IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "التحصيل",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: VerticalDivider(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "المستهدف",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: VerticalDivider(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(
                      "اسم العميل",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Row(
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
                            return const SizedBox.shrink();
                          } else {
                            print("tasks is $taskList");
                            return CompareItem(task: task);
                          }
                        },
                        itemCount: taskList?.length ?? 0,
                      );
                    },
                    stream: MyDataBase.getTasksRealTimeUpdateInAdmin(
                      user.id ?? "",
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot<Target>>(
            builder: (context, targetSnapshot) {
              if (targetSnapshot.hasError) {
                return Container();
              }
              if (targetSnapshot.connectionState == ConnectionState.waiting) {
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
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        'التحصيل: $totalIncome',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        'العجز : $difference',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                stream: MyDataBase.getIncomeRealTimeUpdate(
                  user.id ?? "",
                ),
              );
            },
            stream: MyDataBase.getTargetRealTimeUpdate(
              user.id ?? "",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
