import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Models/task_model.dart';
import 'package:todo_task/Providers/User_Tasks.dart';
import 'package:todo_task/Services/user_services.dart';

class TaskCard extends StatelessWidget {
  late Task task;
  late bool isDone;
  TaskCard({required this.task , required this.isDone});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text('Task Title : ${task.title}'),
                  SizedBox(height: 10,),
                  Text('Task Time : ${task.time}'),
                  SizedBox(height: 10,),
                  Text('Task Date : ${task.date}'),
                ],
              ),
              isDone ? Container() : Column(
                children: [
                  InkWell(
                      onTap: (){
                        Provider.of<UserTasks>(context, listen: false).updateTaskState(task: task);

                      },
                      child: Icon(Icons.done_outline, color: Colors.green,)),
                  SizedBox(height: 10,),
                  InkWell(
                      onTap: (){
                        Provider.of<UserTasks>(context, listen: false).deleteTheTask(task: task);

                      },
                      child: Icon(Icons.close, color: Colors.red,))

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
