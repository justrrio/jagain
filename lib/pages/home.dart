import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Widget Library

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Column(
          children: [TextField()],
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Halo, Andi Subandi",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {},
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
            onTap: () {},
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
}
