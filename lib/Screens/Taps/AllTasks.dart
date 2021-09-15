import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Constant.dart';
import 'package:todo_task/Models/task_model.dart';
import 'package:todo_task/Providers/User_Tasks.dart';
import 'package:todo_task/Services/user_services.dart';
import 'package:todo_task/Widgets/Task_Card.dart';

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
  }
 /* void getData() async {
    bool isConnected = await checkInternet();
    if(isConnected)
      {
       await Provider.of<UserTasks>(context, listen: false).getAllTasksFromFirebase();
       setState(() {
       });
      }
  }


  */
   UserService userService=UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks To Do'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Task>>(
        future: userService.getAllTasks(context),
        builder: (context, snapshot){
          if(snapshot.hasData)
            {
            return ListView.builder(
                itemCount:  Provider.of<UserTasks>(context, listen: true).myTasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(task:   Provider.of<UserTasks>(context, listen: false).myTasks[index], isDone: false,);
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
