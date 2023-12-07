import 'package:flutter/material.dart';
import 'package:localstorage/main.dart';
import 'package:localstorage/model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final inputController = TextEditingController();
  final ownerInputController = TextEditingController();
  List<Owner> owner = objectbox.ownerBox.getAll();
  late Owner currentOwner;

  void createTask() {
    if (inputController.text.isNotEmpty) {
      objectbox.addTask(inputController.text, currentOwner);
    }
  }

  void createOwner() {
    Owner newOwner = Owner(ownerInputController.text);
    objectbox.ownerBox.put(newOwner);
    List<Owner> newOwnerList = objectbox.ownerBox.getAll();
    setState(() {
      currentOwner = newOwner;
      owner = newOwnerList;
    });
  }

  void updateOwner(int ownerId) {
    Owner? newCurrentOwner = objectbox.ownerBox.get(ownerId);
    setState(() {
      currentOwner = newCurrentOwner!;
    });
  }

  @override
  void initState() {
    print(owner.length);
    currentOwner = owner[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        key: UniqueKey(),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: inputController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Assign Owner:",
                    style: TextStyle(fontSize: 17),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton(
                      value: currentOwner.id,
                      items: owner
                          .map((e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.name,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    height: 1.0,
                                    overflow: TextOverflow.fade),
                              )))
                          .toList(),
                      onChanged: (value) {
                        updateOwner(value!);
                      },
                      underline: Container(
                        height: 1.5,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("new Owner"),
                                  content: TextField(
                                    controller: ownerInputController,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        hintText: "Enter the owner name"),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          createOwner();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("submit"))
                                  ],
                                ));
                      },
                      child: Text(
                        "Add Owner",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        createTask();
                        Navigator.of(context).pop();
                      },
                      child: Text("Save"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
