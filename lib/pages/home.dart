import 'package:flutter/material.dart'; // Widget Library;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jagain/pages/whatsapp.dart';
import 'package:jagain/pages/camera.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: <Widget>[
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
              "List Kamera",
              style: TextStyle(
                fontFamily: "Poppins-SemiBold",
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xff364954),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CameraPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width -
                  40, // Lebar layar dikurangi 40 pixels
              height: 200, // Tinggi tetap
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Text(
                "test",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    title: Text(
      "Jagain",
      style: TextStyle(
        fontFamily: "Poppins-Bold",
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xff349A6D),
      ),
    ),
    centerTitle: true,
    leading: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/icons/Logo.svg',
                width: 30, height: 30))),
    actions: [
      GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WhatsappPage()));
          },
          child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/Tambah Kamera.png',
                width: 40,
                height: 40,
              )))
    ],
  );
}
