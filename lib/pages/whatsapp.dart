import 'package:flutter/material.dart';
import 'package:jagain/pages/home.dart';

class WhatsappPage extends StatelessWidget {
  const WhatsappPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              left: 0,
              top: 20,
              right: 0,
              bottom: 20,
            ),
            padding: const EdgeInsets.only(
              left: 25,
              top: 0,
              right: 0,
              bottom: 0,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Tambah Nomor Tetangga",
              style: TextStyle(
                fontFamily: "Poppins-SemiBold",
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xff364954),
              ),
            ),
          )
        ]));
  }
}
