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
            margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 20),
            child: Image.asset(
              "assets/images/WhatsApp Image.png",
              width: MediaQuery.of(context).size.width -
                  40, // Lebar layar dikurangi 40 pixels
              height: 200,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 0,
              top: 20,
              right: 0,
              bottom: 0,
            ),
            padding: const EdgeInsets.only(
              left: 25,
              top: 0,
              right: 0,
              bottom: 0,
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tambah Nomor",
                  style: TextStyle(
                    fontFamily: "Poppins-Bold",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff364954),
                  ),
                ),
                Text(
                  "Masukkan data tetangga Anda.",
                  style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff364954),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 0,
              top: 30,
              right: 0,
              bottom: 0,
            ),
            padding: const EdgeInsets.only(
              left: 25,
              top: 0,
              right: 25,
              bottom: 0,
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nama",
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Nomor Telepon"),
                ),
              ],
            ),
          )
        ]));
  }
}
