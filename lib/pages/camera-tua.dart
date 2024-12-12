import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jagain/pages/home.dart';
import 'package:jagain/pages/call.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class CameraPageTua extends StatefulWidget {
  const CameraPageTua({super.key});

  @override
  State<CameraPageTua> createState() => _CameraPageStateTUa();
}

class _CameraPageStateTUa extends State<CameraPageTua> {
  final dbRef = FirebaseDatabase.instance.ref().child('esp32cam');

  Widget listItem(dynamic esp32cam) {
    String base64Image = '';

    // Check if esp32cam is a valid string
    if (esp32cam is String && esp32cam.length > 10000) {
      print("Base64 Image Length: ${base64Image.length}");
      print("MASUK? $esp32cam");
    } else {
      print('Invalid Base64 string or too short.');
    }

    // Process the Base64 string if it has the correct prefix
    if (base64Image.isNotEmpty) {
      if (base64Image.startsWith('data:image/jpeg;base64,')) {
        base64Image = base64Image.split(',')[1];
      }
      print('Processed Base64 Image Length: ${base64Image.length}');
    } else {
      // print('Base64 Image is empty after processing.');
      print('KOSONG!');
    }

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          alignment: Alignment.center,
          child: base64Image.isNotEmpty
              ? Image.memory(
                  base64Decode(base64Image),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                  errorBuilder: (context, error, stackTrace) {
                    print('Image decoding error: $error');
                    return Text(
                      'Error loading image',
                      style: TextStyle(color: Colors.white),
                    );
                  },
                )
              : Text(
                  "No Image Available",
                  style: TextStyle(color: Colors.white),
                ),
        ),
        // Rest of your existing code...
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 25, top: 430, right: 25, bottom: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff349A6D),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ]),
        )
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
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              // Add more detailed logging
              // print('Snapshot value: ${snapshot.value}');
              final esp32cam = snapshot.value;
              if (esp32cam != null) {
                return listItem(esp32cam);
              } else {
                print("Snapshot is null");
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
