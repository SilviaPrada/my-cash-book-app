import 'package:my_cash_book/helper/dbhelper.dart';
import 'package:my_cash_book/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_cash_book/providers/user_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String developerName = "Silvia Prada Aprilia";
  String developerNim = "2041720141";
  String dateApp = "11 Juli 2024";

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    // Access the UserProvider to get user data
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: const Text(
                "Pengaturan",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold), // Membesarkan ukuran font
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Saat Ini",
                labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 15,), // Membesarkan ukuran font
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
                labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 15), // Membesarkan ukuran font
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changePassword(user!);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFFF09A1A)), // Mengubah warna tombol
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              child: const Text("Simpan Password Baru",
                  style: TextStyle(fontSize: 18)), // Membesarkan ukuran font
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kembali
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF5B7C29)), // Mengubah warna tombol
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              child: const Text("<< Kembali",
                  style: TextStyle(fontSize: 18)), // Membesarkan ukuran font
            ),
            const SizedBox(height: 20),
            Spacer(), // Menambahkan spacer agar "About this App" berada di bagian bawah halaman
            Row(
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0)), // Membuat foto menjadi kotak
                  child: Image(
                    image: AssetImage(
                        'assets/images/biru.jpg'), // path foto profil
                    width: 100,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // create bold heading style
                      const Text(
                        "About this App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18), // Membesarkan ukuran font
                      ),
                      const Text("Aplikasi ini dibuat oleh: ",
                          style: TextStyle(
                              fontSize: 18)), // Membesarkan ukuran font
                      Text("Nama : $developerName",
                          style: TextStyle(
                              fontSize: 18)), // Membesarkan ukuran font
                      Text("NIM : $developerNim",
                          style: TextStyle(
                              fontSize: 18)), // Membesarkan ukuran font
                      Text("Tanggal : $dateApp",
                          style: TextStyle(
                              fontSize: 18)), // Membesarkan ukuran font
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword(User user) {
    String currentPasswordInput = currentPasswordController.text;
    String newPasswordInput = newPasswordController.text;

    if (currentPasswordInput == user.password) {
      // Password saat ini benar, simpan password baru
      dbHelper.changePassword(user.username!, newPasswordInput);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password berhasil diubah."),
      ));
    } else {
      // Password saat ini salah
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password saat ini salah. Ubah password gagal."),
      ));
    }
  }
}
