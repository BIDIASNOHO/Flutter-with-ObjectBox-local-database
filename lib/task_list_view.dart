// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:localstorage/main.dart';
import 'package:localstorage/model.dart';
import 'package:localstorage/task_Card.dart';

class TaskList extends StatefulWidget {
  final int eventId;
  const TaskList({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskCard Function(BuildContext, int) _itemBuilder(List<Task> tasks) {
    return (BuildContext context, int index) => TaskCard(task: tasks[index]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        key: UniqueKey(),
        stream: objectbox.getTasksOfEvent(widget.eventId),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: _itemBuilder(snapshot.data ?? []),
            );
          } else {
            return Center(child: Text("Press the Icon to add Task"));
          }
        });
  }
}
