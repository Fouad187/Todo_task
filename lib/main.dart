import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/Providers/Modal_hud.dart';
import 'package:todo_task/Providers/User_Tasks.dart';
import 'package:todo_task/Screens/HomeScreen.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs=await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserTasks>(create: (context) => UserTasks(),),
        ChangeNotifierProvider<ModalHud>(create: (context) => ModalHud(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id : (context)=>HomeScreen(),
        },
      ),
    );
  }
}