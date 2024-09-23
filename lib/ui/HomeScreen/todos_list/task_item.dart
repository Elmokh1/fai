import 'package:fai/import.dart';

class TaskItem extends StatefulWidget {
  Task task;
  String? CustomerID;

  TaskItem({super.key, required this.task, this.CustomerID});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  var auth = FirebaseAuth.instance;
  User? user;
  double Dincome = 0.0; // إضافة المتغير هنا

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<appProvider>(context);
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.blueAccent.withOpacity(.6),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.blueAccent.withOpacity(.1),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.task.isDone == false) {
                        widget.task.isDone = !widget.task.isDone;
                      }
                    });
                    MyDataBase.editTask(
                      user?.uid ?? "",
                      widget.task.id ?? "",
                      widget.task.isDone,
                    );
                    print(widget.task.isDone);
                    if (widget.task.isDone == true) {
                      showReportModal();
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 7.0),
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: widget.task.isDone == false
                          ? Image.asset("assets/images/Ic_check.png")
                          : Icon(
                              Icons.not_interested_outlined,
                              color: Colors.red,
                            )),
                ),
              ),
              widget.task.isDone == false
                  ? Text(
                      "",
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.task.isDone == false
                            ? Colors.white
                            : Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : StreamBuilder<QuerySnapshot<Report>>(
                      builder: (context, snapshot) {
                        var report = snapshot.data?.docs
                            .map((doc) => doc.data())
                            .toList();
                        return report?[0].income == null
                            ? Text("التحصيل:0  ")
                            : Text("التحصيل:${report?[0].income}" ?? "0");
                      },
                      stream: MyDataBase.getReportRealTimeUpdate(
                        widget.CustomerID ?? user?.uid ?? "",
                        widget.task?.id ?? "",
                      ),
                    ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  widget.task.isDone == false
                      ? Text(
                          "${widget.task.title}",
                          style: TextStyle(
                            fontSize: 18,
                            color: widget.task.isDone == false
                                ? Colors.white
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Text(
                          "${widget.task.title}",
                          style: TextStyle(
                            fontSize: 18,
                            color: widget.task.isDone == false
                                ? theme.primaryColor
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  widget.task.isDone == false
                      ? Text(
                          "${widget.task.desc}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      : Text(
                          "${widget.task.desc}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                ],
              )),
              Container(
                margin: const EdgeInsets.all(20),
                height: 80,
                width: 3,
                color: theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showReportModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ReportModal(
              task: widget.task,
            ),
          ),
        );
      },
    );
  }
}
