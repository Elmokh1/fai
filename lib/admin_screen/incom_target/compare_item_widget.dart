import 'package:intl/intl.dart';

import '../../import.dart';

class CompareItem extends StatelessWidget {
  Task task;

  CompareItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        IntrinsicHeight(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "${task.Income}",
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
            "${task.DailyTarget}",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: VerticalDivider(
            ),

          ),
        ),

        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(
                ' ${DateFormat('yyyy-MM-dd').format(task.dateTime!)}',
                style: TextStyle(fontSize: 12,color: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  "${task.title}",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
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
