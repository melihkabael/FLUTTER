import 'package:flutter/material.dart';
import 'package:todolist_mysql/screens/nalan.dart';
import 'package:todolist_mysql/screens/todolist.dart';
import 'package:todolist_mysql/screens/todolist_mysql.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
       
  child: ListView(
   
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
      
        decoration: BoxDecoration(
          color: Colors.blue,
        
        ),
       
        child: CircleAvatar(
          
          backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/50300070?v=4"),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Arda Samet Çakır 9174'),
        onTap: () {
       Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoList()),
              );
        },
      ),
      ListTile(
        leading: const Icon(Icons.list),
        title: const Text('TodoList'),
        onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoList()),
              );
        },
      ),
      ListTile(
        leading: const Icon(Icons.dataset),
        title: const Text('TodoList MySql'),
        onTap: () {
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoListMysql()),
              );
        },
      ),
            ListTile(
        leading: const Icon(Icons.dataset),
        title: const Text('Nalan'),
        onTap: () {
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Nalan()),
              );
        },
      ),
    ],
  ),
    );
    
  }
}