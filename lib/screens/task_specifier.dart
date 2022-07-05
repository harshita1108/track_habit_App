import 'package:flutter/material.dart';
import 'package:habit_tracking/modules/task_module.dart';
import 'package:habit_tracking/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskSpecifier extends StatefulWidget {
  TaskSpecifier({this.task, Key? key}) : super(key: key);
  Task? task;
  @override
  State<TaskSpecifier> createState() => _TaskSpecifierState();
}

class _TaskSpecifierState extends State<TaskSpecifier> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    TextEditingController _taskNote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          iconTheme: IconThemeData(color: Colors.black45),
          title: Text(
              widget.task == null ? "Add a new task" : "Update your task",
              style: TextStyle(color: Colors.black54)),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Task Title",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _taskTitle,
                decoration: InputDecoration(
                    fillColor: Colors.blueGrey.shade50.withAlpha(75),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "Specify your task here"),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Your Notes",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 15,
                controller: _taskNote,
                decoration: InputDecoration(
                    fillColor: Colors.blueGrey.shade50.withAlpha(75),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "Write down the notes here"),
              ),
              Expanded(
                  child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                    height: 80.0,
                    width: double.infinity,
                    child: RawMaterialButton(
                        onPressed: () {
                          var newTask = Task(
                            title: _taskTitle.text,
                            note: _taskNote.text,
                            creation_date: DateTime.now(),
                            done: false,
                          );
                          Box<Task> tasbox = Hive.box<Task>("tasks");
                          if (widget.task != null) {
                            //to update
                            widget.task!.title = newTask.title;
                            widget.task!.note = newTask.note;
                            widget.task!.save();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => HomeScreen())));
                          } else {
                            //add new task
                            tasbox.add(newTask);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => HomeScreen())));
                          }
                        },
                        fillColor: Colors.blueGrey.shade400,
                        child: Text(
                          widget.task == null
                              ? "Add a new Task"
                              : "Update your current Task",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ))),
              ))
            ],
          ),
        ));
  }
}
