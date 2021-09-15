import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Constant.dart';
import 'package:todo_task/Models/task_model.dart';
import 'package:todo_task/Providers/Modal_hud.dart';
import 'package:todo_task/Providers/User_Tasks.dart';
import 'package:todo_task/Services/user_services.dart';

class AddTask extends StatelessWidget {


  TextEditingController titleController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController statusController=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  UserService userService=UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isChange,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (value){
                    if(value!.isEmpty)
                      {
                        return 'Please fill task title';
                      }
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                    border: OutlineInputBorder(
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: timeController,
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Please fill task time';
                    }
                  },
                  onTap: (){
                    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                      timeController.text = value!.format(context).toString();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Time',
                    labelStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                    border: OutlineInputBorder(
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: dateController,
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Please fill task date';
                    }
                  },
                  onTap: (){
                    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse('2021-12-30')).then((value) {
                      dateController.text='${value!.year} - ${value.month} - ${value.day}';
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Date',
                    labelStyle: TextStyle(
                      fontSize: 18.0,

                    ),

                    border: OutlineInputBorder(

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                MaterialButton(
                  onPressed: () async {
                    final instance = Provider.of<ModalHud>(context, listen: false);
                    instance.changeIsLoading(true);
                    if(formKey.currentState!.validate())
                      {
                        Task task=Task(
                            id: '${titleController.text+timeController.text+TimeOfDay.now().toString()}',
                            title: titleController.text,
                            time: timeController.text,
                            date: dateController.text,
                            status: 'Active'
                        );
                        bool isConnected = await checkInternet();
                        if(isConnected)
                          {
                            /// Add To Backend
                            await Provider.of<UserTasks>(context, listen: false).addTaskToBackend(task: task);
                          }
                        else
                          {
                            /// Add To Local
                            Provider.of<UserTasks>(context, listen: false).addTaskToShared(task: task);
                          }
                      }
                    else {
                      instance.changeIsLoading(false);
                    }
                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                    instance.changeIsLoading(false);
                  },
                  color: Colors.redAccent,
                  child: Text('Add' , style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
