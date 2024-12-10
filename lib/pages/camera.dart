import 'package:flutter/material.dart';
import 'package:jagain/pages/home.dart';
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
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(esp32['image'] ?? 'No image'),
        subtitle: Text('Status: ${esp32['status'] ?? 'No sensor'}'),
        trailing: Icon(Icons.arrow_forward),
      ),
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
