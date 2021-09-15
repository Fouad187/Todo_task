import 'package:flutter/cupertino.dart';

class Task
{
  late String id;
  late String title;
  late String time;
  late String date;
  late String status;
  Task({
    required this.id,
    required this.title,
    required this.time,
    required this.date,
    required this.status,
  });

  Task.fromJson(Map<String,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else {
      id=map['id'];
      title=map['title'];
      time=map['time'];
      date=map['date'];
      status=map['status'];
    }
  }
  toJson()
  {
    return {
      'id':id,
      'title' : title,
      'time' : time,
      'date' : date,
      'status' : status,
    };
  }

}