import 'package:flutter/material.dart';

class HesapMakinesi extends StatefulWidget {
  @override
  _HesapMakinesiState createState() => _HesapMakinesiState();
}

class _HesapMakinesiState extends State {
  String sonuc = "0";
  String denklem = "0";
  String ifade = "";

//Ekranda görünecek olan denklemin boyutunu tanımladık.

  double denklemBoyutu = 40.0;

//Sonuc boyutunu tanımladık.

  double sonucBoyutu = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesap Makinesi"),
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                denklem,
                style: TextStyle(fontSize: denklemBoyutu),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                sonuc,
                style: TextStyle(fontSize: sonucBoyutu),
              ),
            ),
            Expanded(child: Divider()),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        Buttonlar("C", 1, Colors.red),
                        Buttonlar("⌫", 1, Colors.green),
                        Buttonlar("/", 1, Colors.orange),
                      ]),
                      TableRow(children: [
                        Buttonlar("7", 1, Colors.black38),
                        Buttonlar("8", 1, Colors.black38),
                        Buttonlar("9", 1, Colors.black38),
                      ]),
                      TableRow(children: [
                        Buttonlar("4", 1, Colors.black38),
                        Buttonlar("5", 1, Colors.black38),
                        Buttonlar("6", 1, Colors.black38),
                      ]),
                      TableRow(children: [
                        Buttonlar("1", 1, Colors.black38),
                        Buttonlar("2", 1, Colors.black38),
                        Buttonlar("3", 1, Colors.black38),
                      ]),
                      TableRow(children: [
                        Buttonlar(".", 1, Colors.black38),
                        Buttonlar("0", 1, Colors.black38),
                        Buttonlar("00", 1, Colors.black38),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        Buttonlar("*", 1, Colors.orange),
                      ]),
                      TableRow(children: [
                        Buttonlar("+", 1, Colors.orange),
                      ]),
                      TableRow(children: [
                        Buttonlar("-", 1, Colors.orange),
                      ]),
                      TableRow(children: [
                        Buttonlar("=", 2, Colors.red),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Buttonlar(
      String buttonIcerik, double buttonYukseklik, Color buttonRenk) {
    return Container(
      margin: EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: buttonRenk),
      height: MediaQuery.of(context).size.height * 0.1 * buttonYukseklik,
      //color: buttonRenk,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.all(0),
        ),
        onPressed: () => buttonPress(buttonIcerik),
        child: Text(
          buttonIcerik,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  buttonPress(buttonIcerik) {
    setState(() {
      if (buttonIcerik == "C") {
        denklem = "0";
        sonuc = "0";
      }
    });
  }
}
