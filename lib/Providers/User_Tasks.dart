import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/Constant.dart';
import 'package:todo_task/Models/task_model.dart';
import 'package:todo_task/Screens/Taps/DoneTasks.dart';
import 'package:todo_task/Screens/Taps/OfflineTasks.dart';
import 'package:todo_task/Services/user_services.dart';

class UserTasks extends ChangeNotifier
{
  List<Task> myTasks=[];
  List<Task> offlineTasks=[];
  List<Task> doneTasks=[];
  UserService userService=UserService();

  addToMyTasks(Task task)
  {
    myTasks.add(task);
    notifyListeners();
  }
  removeFromMyTasks(Task task)
  {
    myTasks.remove(task);
    notifyListeners();
  }
  addToMyDoneTasks(Task task)
  {
    doneTasks.add(task);
    notifyListeners();
  }
  removeFromMyDoneTasks(Task task)
  {
    doneTasks.remove(task);
    notifyListeners();
  }
  addToMyOfflineTasks(Task task)
  {
    offlineTasks.add(task);
    notifyListeners();
  }
  removeFromMyOfflineTasks(Task task)
  {
    offlineTasks.remove(task);
    notifyListeners();
  }
  clearMyOfflineTask()
  {
    offlineTasks=[];
    notifyListeners();
  }
  addTaskToBackend({required Task task})
  {
    userService.addNewTask(task: task);
    addToMyTasks(task);
  }
  Future<void> addTaskToShared({required Task task}) async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myOfflineTasksInShared=prefs.getString('Tasks') ?? '';
    List<Task> offTasks=[];
    if(myOfflineTasksInShared != '')
      {
        var dataInShared = jsonDecode(myOfflineTasksInShared);
        for(int i=0; i<dataInShared.length ; i++)
          {
            offTasks.add(Task.fromJson(dataInShared[i]));
          }
        offTasks.add(task);
        String myOfflineTasksToShared=jsonEncode(offTasks);
        prefs.setString('Tasks', myOfflineTasksToShared);
      }
    else
      {
        offTasks.add(task);
        String myOfflineTasksToShared=jsonEncode(offTasks);
        prefs.setString('Tasks', myOfflineTasksToShared);
      }
    offlineTasks.add(task);
  }

  Future<List<Task>> getTasksFromShared() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myOfflineTasksInShared=prefs.getString('Tasks') ?? '';
    List<Task> allOfflineTasks=[];
    if(myOfflineTasksInShared != '')
    {
      var dataInShared = jsonDecode(myOfflineTasksInShared);
      for(int i=0; i<dataInShared.length ; i++)
      {
        allOfflineTasks.add(Task.fromJson(dataInShared[i]));
      }
      String myOfflineTasksToShared=jsonEncode(allOfflineTasks);
      prefs.setString('Tasks', myOfflineTasksToShared);
    }
     offlineTasks=allOfflineTasks;

    return allOfflineTasks;
  }


  updateTaskState({required Task task}) async
  {
    userService.updateStatus(task: task).then((value) {
      removeFromMyTasks(task);
      addToMyDoneTasks(task);
    });
    notifyListeners();
  }
  deleteTheTask({required Task task}) async
  {
    userService.deleteTask(task: task).then((value) {
      removeFromMyTasks(task);
    });
    notifyListeners();
  }
}