import 'package:flutter/material.dart';
import 'package:jagain/pages/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final dbRef = FirebaseDatabase.instance.ref().child('phone');

  Widget listPhone({required Map phone}) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () async {
          final String number = phone['nomor'].toString();
          final Uri whatsapp = Uri.parse("https://wa.me/$number");
          try {
            if (await canLaunchUrl(whatsapp)) {
              await launchUrl(whatsapp);
              print("Successfully launched URL");
            } else {
              print("Cannot launch URL");
            }
          } catch (e) {
            print("Error: $e");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phone['nama'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    phone['nomor'].toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.call,
                size: 40,
                color: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 0, top: 30, right: 0, bottom: 20),
            child: Image.asset(
              "assets/images/Call Image.png",
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
                  "Panggil Tetangga",
                  style: TextStyle(
                    fontFamily: "Poppins-Bold",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff364954),
                  ),
                ),
                Text(
                  "Pilih nomor tetangga Anda.",
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
          Expanded(
            child: FirebaseAnimatedList(
                query: dbRef, // Query ke Firebase Database
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  if (snapshot.value != null) {
                    Map phone = snapshot.value as Map;

                    return listPhone(phone: phone);
                  } else {
                    print("Snapshot kosong atau null");
                    return const SizedBox.shrink(); // Widget kosong
                  }
                }),
          ),
        ]));
  }
}
