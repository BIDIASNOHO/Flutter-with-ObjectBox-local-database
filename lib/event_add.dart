import 'package:flutter/material.dart';
import 'package:localstorage/main.dart';
import 'package:localstorage/model.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final eventNameController = TextEditingController();
  final eventLocationController = TextEditingController();
  DateTime? currentDate;

  void createEvent() {
    if (eventLocationController.text.isNotEmpty &&
        eventLocationController.text.isNotEmpty &&
        currentDate != null) {
      objectbox.addEvent(
        eventNameController.text,
        currentDate!,
        eventLocationController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add event"),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: eventNameController,
                  decoration: InputDecoration(
                    labelText: "Event Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: eventLocationController,
                  decoration: InputDecoration(
                    labelText: "Event Location",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(currentDate != null
                          ? "Date: {DateFormat.yMd().format(currentDate!)}"
                          : "Date: Not Selected"),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2050))
                                .then((value) {
                              setState(() {
                                currentDate = value;
                              });
                            });
                          },
                          child: Text(
                            "Select Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          createEvent();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
