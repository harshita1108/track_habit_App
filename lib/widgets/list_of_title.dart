import 'package:flutter/material.dart';
import 'package:habit_tracking/modules/task_module.dart';
import 'package:habit_tracking/screens/task_specifier.dart';

class ListTitle extends StatefulWidget {
  ListTitle(this.task, this.index, {Key? key}) : super(key: key);
  Task task;
  int index;
  @override
  State<ListTitle> createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 12.0),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(widget.task.title!,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold))),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  TaskSpecifier(task: widget.task))));
                    },
                    icon: Icon(Icons.edit, color: Colors.green)),
                IconButton(
                    onPressed: () {
                      widget.task.delete();
                    },
                    icon: Icon(Icons.delete, color: Colors.redAccent))
              ],
            ),
            Divider(
              color: Colors.black45,
              height: 20.0,
              thickness: 1.0,
            ),
            Text(widget.task.note!)
          ],
        ));
  }
}
