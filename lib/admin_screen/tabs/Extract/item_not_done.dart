import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../database/model/task_model.dart';

class ItemNotDone extends StatelessWidget {
  Task task;

  ItemNotDone({required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "${task.title}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 1,
                child: Text("${task.DailyTarget}"),
              ),
              VerticalDivider(),
              Expanded(
                flex: 1,
                child: Text(
                  '${DateFormat('MM-dd').format(task.dateTime!)}',
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 3,
                child: Text(
                  "${task.desc}",
                  maxLines: 5,
                  style: TextStyle(fontSize: 10),
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

