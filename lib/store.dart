import 'model.dart';
import 'objectbox.g.dart';

class Objectbox {
  late final Store store;
  late final Box<Task> taskBox;
  late final Box<Owner> ownerBox;
  late final Box<Event> eventBox;

  Objectbox._create(this.store) {
    taskBox = Box<Task>(store);
    ownerBox = Box<Owner>(store);
    eventBox = Box<Event>(store);

    if (eventBox.isEmpty()) {
      _putDemoData();
    }
  }

  static Future<Objectbox> create() async {
    final store = await openStore();
    return Objectbox._create(store);
  }

  void _putDemoData() {
    Event event = Event(
      "Met Gala",
      date: DateTime.now(),
      location: "New York, USA",
    );
    Owner owner1 = Owner("Eren");
    Owner owner2 = Owner("Mikassa");

    Task task1 = Task("That is Mikassa's task");
    task1.owner.target = owner1;
    Task task2 = Task("That is Eren's task");
    task2.owner.target = owner2;
    event.tasks.addAll([task1, task2]);
    eventBox.put(event);
  }

  void addTask(String taskText, Owner owner, Event event) {
    Task newtask = Task(taskText);
    newtask.owner.target = owner;
    newtask.event.target = event;
    event.tasks.add(newtask);
    taskBox.put(newtask);
    print(
        "Added Task: ${newtask.text} assigned to ${newtask.owner.target!.name} in event ${event.name}");
  }

  int addOwner(String newOwner) {
    Owner ownerToAdd = Owner(newOwner);
    int newObjectId = ownerBox.put(ownerToAdd);
    return newObjectId;
  }

  void addEvent(String name, DateTime date, String location) {
    Event newEvent = Event(name, date: date, location: location);
    eventBox.put(newEvent);

    print("Add Event : ${newEvent.name}");
  }

  Stream<List<Event>> getEvent() {
    final builder = eventBox.query()..order(Event_.date);
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  Stream<List<Task>> getTasksOfEvent(int eventId) {
    final builder = taskBox.query()..order(Task_.id, flags: Order.descending);
    builder.link(Task_.event, Event_.id.equals(eventId));
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
