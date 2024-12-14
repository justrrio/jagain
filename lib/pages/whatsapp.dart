import 'package:flutter/material.dart';
import 'package:jagain/pages/home.dart';
import 'package:firebase_database/firebase_database.dart';

class WhatsappPage extends StatefulWidget {
  const WhatsappPage({super.key});

  @override
  State<WhatsappPage> createState() => _WhatsappPageState();
}

class _WhatsappPageState extends State<WhatsappPage> {
  bool isLoading = false;
  final dbRef = FirebaseDatabase.instance.ref().child('phone');
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final url = "https://api.whatsapp.com/send?phone=62";

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
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nama",
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Nomor Telepon"),
              ),
            ],
          ),
        ),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 25, top: 50, right: 25, bottom: 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 22),
                  minimumSize: Size.fromHeight(52),
                  shape: StadiumBorder(),
                  backgroundColor: Color(0xff349A6D)),
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        const SizedBox(width: 24),
                        Text(
                          "Mohon tunggu...",
                          style: TextStyle(
                              fontFamily: 'Poppins-Semibold',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white),
                        )
                      ],
                    )
                  : Text(
                      "Submit",
                      style: TextStyle(
                          fontFamily: 'Poppins-Semibold',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
              onPressed: () async {
                // Jika sudah loading, jangan proses ulang
                if (isLoading) return;

                // Atur isLoading ke true untuk menampilkan animasi
                setState(() => isLoading = true);

                try {
                  // Simpan data ke Firebase
                  await dbRef.child(DateTime.now().microsecond.toString()).set({
                    "nama": nameController.text.trim(),
                    "nomor": phoneController.text.trim(),
                  });

                  // Beri umpan balik jika berhasil (opsional)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data berhasil disimpan!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  // Tampilkan pesan kesalahan jika gagal
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal menyimpan data: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } finally {
                  // Kembalikan isLoading ke false untuk mengganti tombol kembali ke "Submit"
                  setState(() => isLoading = false);

                  // Kosongkan text field (opsional)
                  nameController.clear();
                  phoneController.clear();
                }
              },
            ))
      ]),
    );
  }
}
