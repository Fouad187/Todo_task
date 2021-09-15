import 'package:flutter/material.dart';
import 'package:todo_task/Screens/Taps/AddTask.dart';
import 'package:todo_task/Screens/Taps/AllTasks.dart';
import 'package:todo_task/Screens/Taps/DoneTasks.dart';
import 'package:todo_task/Screens/Taps/OfflineTasks.dart';


class HomeScreen extends StatefulWidget {
  static String id='HomeScreenID';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  final tabs=[
    AllTasks(),
    AddTask(),
    OfflineTasks(),
    DoneTasks(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent,
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.not_interested),
            label: 'Offline Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Done',
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}