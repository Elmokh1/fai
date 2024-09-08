import 'package:fai/admin_screen/tabs/Extract/item_not_done.dart';

import '../../../database/model/customer_model.dart';
import '../../../import.dart';

class ExtractNotDoneTask extends StatefulWidget {
  DateTime day;
  CustomerModel user;

  ExtractNotDoneTask({required this.day, required this.user});

  @override
  State<ExtractNotDoneTask> createState() => _ExtractNotDoneTaskState();
}

class _ExtractNotDoneTaskState extends State<ExtractNotDoneTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "اسم لعميل",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "المستهدف",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                      flex: 1,
                      child: Text(
                        "التاريخ",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      )),
                  VerticalDivider(),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "سبب الزياره",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      )),
                ],
              ),
            ),
          ),
          Divider(),
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
                      return SizedBox.shrink();
                    } else {
                      return Directionality(textDirection: TextDirection.rtl,child: ItemNotDone(task: task));
                    }
                  },
                  itemCount: taskList?.length ?? 0,
                );
              },
              stream: MyDataBase.getTasksRealTimeUpdateWithWeek(
                widget.user.id ?? "",
                MyDateUtils.dateOnly(widget.day).millisecondsSinceEpoch,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
