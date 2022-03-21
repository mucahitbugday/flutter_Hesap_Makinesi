// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HesapMakinesi extends StatefulWidget {
  const HesapMakinesi({Key? key}) : super(key: key);

  @override
  _HesapMakinesiState createState() => _HesapMakinesiState();
}

class _HesapMakinesiState extends State<HesapMakinesi> {
  String sonuc = "0";
  String denklem = "0";
  String ifade = "";
  double denklemBoyutu = 40.0;

  double sonucBoyutu = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesap Makinesi"),
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                denklem,
                style: TextStyle(fontSize: denklemBoyutu),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                sonuc,
                style: TextStyle(fontSize: sonucBoyutu),
              ),
            ),
            const Expanded(child: Divider()),
            Row(
              children: [
                SizedBox(
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
                SizedBox(
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
                        Buttonlar("=", 2.15, Colors.red),
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

  // ignore: non_constant_identifier_names
  Widget Buttonlar(
      String buttonIcerik, double buttonYukseklik, Color buttonRenk) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: buttonRenk),
      height: MediaQuery.of(context).size.height * 0.1 * buttonYukseklik,
      //color: buttonRenk,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(0),
        onPressed: () => buttonPress(buttonIcerik),
        child: Text(
          buttonIcerik,
          style: const TextStyle(
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
      } else if (buttonIcerik == "⌫") {
        denklem = denklem.substring(0, denklem.length - 1);
        if (denklem == "") {
          denklem = "0";
        }
      } else if (buttonIcerik == "=") {
        ifade = denklem;

        try {
          Parser p = Parser();
          Expression exp = p.parse(ifade);
          // ignore: non_constant_identifier_names
          ContextModel Cm = ContextModel();
          sonuc = "${exp.evaluate(EvaluationType.REAL, Cm)}";
        } catch (e) {
          sonuc = "Hata";
        }
      } else {
        if (denklem == "0") {
          denklem = buttonIcerik;
        } else {
          denklem = denklem + buttonIcerik;
        }
      }
    });
  }
}
