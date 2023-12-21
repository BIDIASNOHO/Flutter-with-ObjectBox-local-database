// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:localstorage/model.dart';
import 'package:localstorage/task_Page.dart';

class EventCard extends StatefulWidget {
  final Event event;
  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => TaskPage(event: widget.event)));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 243, 243),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(255, 167, 167, 167),
                  blurRadius: 5,
                  offset: Offset(1, 2))
            ]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      widget.event.name!,
                      style: TextStyle(
                          fontSize: 25,
                          height: 1.0,
                          overflow: TextOverflow.fade),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location : ${widget.event.location}",
                          style: TextStyle(
                              fontSize: 15.0,
                              height: 1.0,
                              overflow: TextOverflow.fade),
                        ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            "Date: {DateFormat.yMd().format(widget.event.date)}",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 1.0,
                                overflow: TextOverflow.fade),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
