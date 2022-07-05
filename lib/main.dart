import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracking/screens/task_specifier.dart';
import 'package:habit_tracking/widgets/list_of_title.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:habit_tracking/modules/task_module.dart';

late Box box;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  box.add(Task(
      title: "This is the first task",
      note: "Share the important note!",
      creation_date: DateTime.now()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "Tasks List",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("tasks").listenable(),
        builder: (context, box, _) {
          return Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Today's Tasks",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    formatDate(DateTime.now(), [d, ",", M, " ", yyyy]),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Divider(
                    height: 40.0,
                    thickness: 1.0,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            Task currentTask = box.getAt(index)!;
                            return ListTitle(currentTask, index);
                          }))
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TaskSpecifier()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
