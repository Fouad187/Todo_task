import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Models/task_model.dart';
import 'package:todo_task/Providers/User_Tasks.dart';
import 'package:todo_task/Services/user_services.dart';
import 'package:todo_task/Widgets/Task_Card.dart';
class DoneTasks extends StatelessWidget {
  UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done Tasks'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List<Task>>(
        future: userService.getAllDoneTasks(context),
        builder: (context, snapshot){
          if(snapshot.hasData)
          {
            return ListView.builder(
                itemCount:  Provider.of<UserTasks>(context, listen: true).doneTasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(task:   Provider.of<UserTasks>(context, listen: false).doneTasks[index], isDone: true,);
                }
            );
          }
          else if(snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError)
          {
            return Center(child: Text('Error has occured , Please Check internet'),);
          }
          else {
            return Center(child: Text('No Internet Connection'),);
          }
        },
      )
    );
  }
}
