import 'package:flutter/material.dart';
import 'package:todolist_mysql/screens/nalan.dart';
import 'package:todolist_mysql/screens/todolist%20copy.dart';
import 'screens/todolist_mysql.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: "/",
     routes: {
     "/Todolist":(context) => const Todolist(),
      "/Nalan":(context) => const Nalan(),
     "/":(context) => const TodoListMysql(),
   

     },
      // home: ortalamatik(),
    );
  }
}