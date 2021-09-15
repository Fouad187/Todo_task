import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Models/task_model.dart';
import 'package:todo_task/Providers/Modal_hud.dart';
import 'package:todo_task/Providers/User_Tasks.dart';
import 'package:todo_task/Services/user_services.dart';
import 'package:todo_task/Widgets/Task_Card.dart';
class OfflineTasks extends StatelessWidget {
  UserService userService=UserService();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:Provider.of<ModalHud>(context).isChange,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Offline Tasks'),
          backgroundColor: Colors.redAccent,
          actions: [
            MaterialButton(onPressed: () async {
              final instance = Provider.of<ModalHud>(context, listen: false);
              instance.changeIsLoading(true);
              userService.syncOfflineTasks(context).then((value) {
                instance.changeIsLoading(false);
              });
            },
            child: Row(children: [
              Icon(Icons.wifi , color: Colors.white,),
             SizedBox(width: 5,),
              Text('Sync' , style: TextStyle(color: Colors.white , fontSize: 20),),
            ],),
            ),
          ],
        ),
        body: FutureBuilder<List<Task>>(
          future:   Provider.of<UserTasks>(context, listen: true).getTasksFromShared(),
          builder: (context, snapshot){
            if(snapshot.hasData)
            {
              return ListView.builder(
                itemCount:   Provider.of<UserTasks>(context, listen: true).offlineTasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(task:   Provider.of<UserTasks>(context, listen: true).offlineTasks[index] , isDone: true,);
                },
              );
            }
            else if(snapshot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              return Center(child: Text('No Internet Connection'),);
            }
          },
        )
      ),
    );
  }
}
