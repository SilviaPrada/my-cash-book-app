import 'package:my_cash_book/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenditurePage extends StatefulWidget {
  AddExpenditurePage({Key? key}) : super(key: key);

  @override
  State<AddExpenditurePage> createState() => _AddExpenditurePageState();
}

class _AddExpenditurePageState extends State<AddExpenditurePage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final DbHelper dbHelper = DbHelper();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void resetForm() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    amountController.clear();
    descriptionController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Tambah Pengeluaran",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold), // Membesarkan ukuran font
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Tanggal",
                      labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 15), // Membesarkan ukuran font
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today,
                      color: Colors.green, size: 30), // Icon kalender
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ],
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Jumlah (Nominal)",
                labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 15), // Membesarkan ukuran font
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Keterangan",
                labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 15), // Membesarkan ukuran font
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFF09A1A)), // Warna tombol simpan
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      resetForm();
                    },
                    child: const Text("Reset",
                        style:
                            TextStyle(fontSize: 18)), // Membesarkan ukuran font
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF5B7C29)), // Warna tombol simpan
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      String date = dateController.text;
                      String amount = amountController.text;
                      String description = descriptionController.text;

                      if (date.isNotEmpty && amount.isNotEmpty) {
                        int rowCount = await dbHelper.insertExpense(
                            date, amount, description);
                        if (rowCount > 0) {
                          // Successfully added expense data
                          resetForm(); // Reset the form
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Pengeluaran berhasil disimpan."),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Gagal menyimpan pengeluaran."),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Tanggal dan Jumlah harus diisi."),
                          ),
                        );
                      }
                    },
                    child: const Text("Simpan",
                        style:
                            TextStyle(fontSize: 18)), // Membesarkan ukuran font
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman Beranda
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF5B7C29)), // Warna tombol kembali
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    child: const Text("<< Kembali",
                        style:
                            TextStyle(fontSize: 18)), // Membesarkan ukuran font
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
