// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:localstorage/model.dart';
import 'package:localstorage/task_add.dart';
import 'package:localstorage/task_list_view.dart';

class TaskPage extends StatefulWidget {
  final Event event;
  const TaskPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: Text("Tasks  for ${widget.event.name}"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: 
            TaskList(eventId: widget.event.id!))
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddTask(event: widget.event)));
              setState(() {
                
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
