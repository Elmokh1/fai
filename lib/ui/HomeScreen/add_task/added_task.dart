import '../../../import.dart';

class AddedTask extends StatefulWidget {
  Task task;

  AddedTask({required this.task});

  @override
  State<AddedTask> createState() => _AddedTaskState();
}

class _AddedTaskState extends State<AddedTask> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Expanded(child: Text("${widget.task.title}"),flex: 4,),
              widget.task.isDone == false
                  ? Expanded(
                    child: Text(
                        "لم تتم الزياره",
                        style: GoogleFonts.inter(
                          color: Colors.red,
                          fontSize: 10,
                        ),
                      ),
                flex: 3,
                  )
                  : Expanded(
                    child: Text(
                        "تمت الزياره ",
                        style: GoogleFonts.inter(
                          color: Colors.blue,
                          fontSize: 10,
                        ),
                      ),
                flex: 3,

              ),
              Expanded(
                flex: 1,

                child: InkWell(
                  onTap: () {
                    MyDataBase.deleteTask(user?.uid ?? "", widget.task?.id ?? "");
                    setState(() {});
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
