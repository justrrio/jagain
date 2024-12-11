import 'package:flutter/material.dart';
import 'package:jagain/pages/home.dart';
import 'package:jagain/pages/call.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class CameraPage extends StatefulWidget {
  CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final Query dbRef = FirebaseDatabase.instance.ref().child('esp32');

  Widget listItem({required Map esp32}) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300, // Tinggi tetap
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          alignment: Alignment.center,
          child: Text(
            "test",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 25, top: 430, right: 25, bottom: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff349A6D),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.call,
                size: 40,
                color: Colors.white,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CallPage()));
                },
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 22),
                    shape: StadiumBorder(),
                    backgroundColor: Color(0xff349A6D),
                    shadowColor: Colors.transparent),
                child: Text(
                  "Call",
                  style: TextStyle(
                      fontFamily: 'Poppins-Semibold',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FirebaseAnimatedList(
            query: dbRef, // Query ke Firebase Database
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              if (snapshot.value != null) {
                Map esp32 = snapshot.value as Map;

                // print("Data ditemukan: $esp32");

                return listItem(esp32: esp32);
              } else {
                print("Snapshot kosong atau null");
                return const SizedBox.shrink(); // Widget kosong
              }
            }),
      ),
    );
  }
}
