import 'package:flutter/material.dart';
import 'package:todolist_mysql/screens/mydrawer.dart';

class Nalan extends StatefulWidget {
  const Nalan({super.key});

  @override
  State<Nalan> createState() => _NalanState();
}

class _NalanState extends State<Nalan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Mydrawer(),
        appBar: AppBar(
          title: const Text("Arda4a"),
          centerTitle: true,
          actions: const [
            Icon(Icons.settings),
            SizedBox(
              width: 5,
            )
          ],
        ),
        body: Container(
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("N", Colors.teal[900]!),
                    box("A", Colors.teal[800]!),
                    box("L", Colors.teal[700]!),
                    box("A", Colors.teal[600]!),
                    box("N", Colors.teal[500]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("A", Colors.teal[800]!),
                    box("A", Colors.teal[800]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("L", Colors.teal[700]!),
                    box("L", Colors.teal[700]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("A", Colors.teal[600]!),
                    box("A", Colors.teal[600]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("N", Colors.teal[900]!),
                    box("A", Colors.teal[800]!),
                    box("L", Colors.teal[700]!),
                    box("A", Colors.teal[600]!),
                    box("N", Colors.teal[500]!),
                  ],
                ),
              ],
            )));
  }
}

Widget box(String word, Color color) {
  return Container(
    color: color,
    width: 80,
    height: 120,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          word,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}