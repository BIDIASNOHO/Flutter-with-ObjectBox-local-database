import 'package:flutter/material.dart';
import 'package:localstorage/task_Card.dart';
import 'package:localstorage/task_add.dart';
import 'package:localstorage/task_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Manager"),
      ),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddTask()));
              setState(() {
                
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
