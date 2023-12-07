import 'package:flutter/material.dart';
import 'package:localstorage/main.dart';
import 'package:localstorage/model.dart';
import 'package:localstorage/task_Card.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

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
        stream: objectbox.getTasks(),
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
