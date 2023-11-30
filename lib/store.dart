import 'model.dart';
import 'objectbox.g.dart';

class Objectbox {
  late final Store store;
  late final Box<Task> taskBox;
  late final Box<Owner> ownerBox;

  Objectbox._create(this.store) {
    taskBox = Box<Task>(store);
    ownerBox = Box<Owner>(store);

    if (taskBox.isEmpty()) {
      _putDemoData();
    }
  }

  static Future<Objectbox> create() async {
    final store = await openStore();
    return Objectbox._create(store);
  }

  void _putDemoData() {
    Owner owner1 = Owner("Eren");
    Owner owner2 = Owner("Mikassa");

    Task task1 = Task("That is Mikassa's task");
    task1.owner.target = owner1;
    Task task2 = Task("That is Eren's task");
    task2.owner.target = owner1;
    taskBox.putMany([task1, task2]);
  }

  void addTask(String taskText, Owner owner) {
    Task newtask = Task(taskText);
    newtask.owner.target = owner;
    taskBox.put(newtask);

    print(
        "Added Task: ${newtask.text} assigned to ${newtask.owner.target!.name}");
  }

  int addOwner(String newOwner) {
    Owner ownerToAdd = Owner(newOwner);
    int newObjectId = ownerBox.put(ownerToAdd);
    return newObjectId;
  }

  Stream<List<Task>> getTasks() {
    final builder = taskBox.query()..order(Task_.id, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
