import 'package:flutter/material.dart';
import 'package:todolist_mysql/screens/mydrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex = 0;
  List<Widget> menuitems = [
    const Text('Anasayfa'),
    const Text('Kurumsal'),
    const Text('İletişim'),
    const Text('Ayarlar'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: selectedindex == 0 ? Colors.amber : Colors.black87),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.open_in_browser_rounded,
                color: selectedindex == 1 ? Colors.amber : Colors.black87),
            label: 'Kurumsal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone,
                color: selectedindex == 2 ? Colors.amber : Colors.black87),
            label: 'İletişim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,
                color: selectedindex == 3 ? Colors.amber : Colors.black87),
            label: 'Ayarlar',
          )
        ],
        currentIndex: selectedindex,
        selectedItemColor: Colors.amber,
        onTap: (int index) {
          setState(() {
            selectedindex = index;
          });
        },
      ),
      drawer: const Mydrawer(),
      appBar: AppBar(
        title: const Text("Hoşgeldiniz!"),
      ),
      body: const Center(
        child: Text("Ana Sayfa"),
      ),
    );
  }
}
