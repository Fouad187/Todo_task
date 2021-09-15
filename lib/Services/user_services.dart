import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/Constant.dart';
import 'package:todo_task/Models/task_model.dart';
import 'package:todo_task/Providers/User_Tasks.dart';

class UserService
{

  Future<void> addNewTask({required Task task}) async
  {
    await FirebaseFirestore.instance.collection('Tasks').doc(task.id).set(task.toJson());
  }
  Future<List<Task>> getAllTasks(context) async
  {
    List<Task>  tasks=[];
    await FirebaseFirestore.instance.collection('Tasks').where('status' , isEqualTo: 'Active').get().then((value) => {

      for(int i=0 ; i<value.docs.length; i++)
        {
          tasks.add(Task.fromJson(value.docs[i].data())),
        }
      ,
       Provider.of<UserTasks>(context, listen: false).myTasks=tasks,
    });
    return tasks;
  }
  Future<List<Task>> getAllDoneTasks(context) async
  {
    List<Task>  tasks=[];
    await FirebaseFirestore.instance.collection('Tasks').where('status' , isEqualTo: 'Done').get().then((value) => {

      for(int i=0 ; i<value.docs.length; i++)
        {
          tasks.add(Task.fromJson(value.docs[i].data())),
        },
      Provider.of<UserTasks>(context, listen: false).doneTasks=tasks,
    });
    return tasks;
  }
   Future<void> updateStatus({required Task task}) async
  {
    await FirebaseFirestore.instance.collection(
        'Tasks').doc(task.id).update(
        {'status': 'Done'});
  }
  Future<void> deleteTask({required Task task}) async
  {
    await FirebaseFirestore.instance.collection(
        'Tasks').doc(task.id).delete();
  }
  Future<void> syncOfflineTasks(context) async
  {
    bool isConnected = await checkInternet();
    if(isConnected)
      {
        Provider.of<UserTasks>(context, listen: false).offlineTasks.forEach((task) {
          addNewTask(task: task);
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('Tasks', '');
        Provider.of<UserTasks>(context, listen: false).clearMyOfflineTask();
      }
  }
}