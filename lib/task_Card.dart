// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:localstorage/main.dart';

import 'package:localstorage/model.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  List<Owner> owners = objectbox.ownerBox.getAll();
  Owner? currentOwner;
  late bool taskStatus;

  void toogleChecBox() {
    bool newStatus = widget.task.setFinishid();
    objectbox.taskBox.put(widget.task);
    setState(() {
      taskStatus = newStatus;
    });
  }

  @override
  void initState() {
    currentOwner = widget.task.owner.target;
    taskStatus = widget.task.status;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 244, 244),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 169, 169, 169),
                blurRadius: 5,
                offset: Offset(1, 2))
          ]),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
                shape: CircleBorder(),
                value: taskStatus,
                onChanged: (bool? value) {
                  toogleChecBox();
                }),
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(widget.task.text,
                    style: taskStatus == true
                        ? TextStyle(
                            fontSize: 20.0,
                            height: 1.0,
                            color: const Color.fromARGB(255, 74, 74, 74),
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.lineThrough)
                        : TextStyle(
                            fontSize: 20.0,
                            height: 1.0,
                            overflow: TextOverflow.ellipsis)),
              )),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Assigned to : ${currentOwner!.name}",
                      style: taskStatus == true
                          ? TextStyle(
                              fontSize: 15.0,
                              height: 1.0,
                              color: const Color.fromARGB(255, 108, 108, 108),
                              decoration: TextDecoration.lineThrough)
                          : TextStyle(
                              fontSize: 15.0,
                              height: 1.0,
                              overflow: TextOverflow.fade),
                    )
                  ],
                ),
              ))
            ],
          )),
          PopupMenuButton<MenuElement>(
            onSelected: (item) {
              return onSelected(context, widget.task);
            },
            itemBuilder: (BuildContext context) {
              return [...MenuItems.itemsFirst.map((buildItem)).toList()];
            },
            child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.more_horiz, color: Colors.grey)),
          )
        ],
      ),
    );
  }

  PopupMenuItem<MenuElement> buildItem(MenuElement item) {
    return PopupMenuItem<MenuElement>(value: item, child: Text(item.text!));
  }

  void onSelected(BuildContext context, Task task) {
    objectbox.taskBox.remove(task.id);
    print("Task Deleted");
  }
}

class MenuElement {
  final String? text;
  const MenuElement({
    required this.text,
  });
}

class MenuItems {
  static List<MenuElement> itemsFirst = [itemDelete];
  static const itemDelete = MenuElement(text: "Delete");
}
