import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jagain/pages/call.dart';
import 'package:jagain/pages/home.dart';
import 'package:firebase_database/firebase_database.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final dbRef = FirebaseDatabase.instance.ref().child('esp32camdata');

  Widget buildImage(String base64Image) {
    try {
      // Hilangkan prefix jika ada
      if (base64Image.startsWith('data:image/jpeg;base64,')) {
        base64Image = base64Image.split(',')[1];
      }

      return Image.memory(
        base64Decode(base64Image),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            'Error loading image',
            style: TextStyle(color: Colors.white),
          );
        },
      );
    } catch (e) {
      print('Error decoding image: $e');
      return const Text(
        'Invalid image data',
        style: TextStyle(color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            final data = snapshot.data!.snapshot.value;
            String base64Image = '';

            if (data is Map &&
                data.containsKey('image') &&
                data['image'] is String) {
              base64Image = data['image'];
            } else if (data is String) {
              base64Image = data;
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: const BoxDecoration(color: Colors.black),
                    alignment: Alignment.center,
                    child: base64Image.isNotEmpty
                        ? buildImage(base64Image)
                        : const Text(
                            'No Image Available',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, top: 0, right: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CallPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 22),
                        shape: const StadiumBorder(),
                        backgroundColor: const Color(0xff349A6D),
                        shadowColor: Colors.transparent,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff349A6D),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.call,
                              size: 40,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Call",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Semibold",
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
