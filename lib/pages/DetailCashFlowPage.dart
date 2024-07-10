import 'package:my_cash_book/constant/finance_type_constants.dart';
import 'package:my_cash_book/helper/dbhelper.dart';
import 'package:my_cash_book/models/cashbook.dart';
import 'package:flutter/material.dart';

class DetailCashFlowPage extends StatefulWidget {
  @override
  _DetailCashFlowPageState createState() => _DetailCashFlowPageState();
}

class _DetailCashFlowPageState extends State<DetailCashFlowPage> {
  List<CashBook> cashFlowData = [];

  @override
  void initState() {
    super.initState();
    _fetchCashFlowData();
  }

  Future<void> _fetchCashFlowData() async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database
    List<CashBook> data = await dbHelper.getCashBook();

    setState(() {
      cashFlowData = data;
    });
  }

  Future<void> _deleteItem(int index) async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database

    // Delete the item from the database
    await dbHelper.deleteDataCashBook(cashFlowData[index].id!);

    // Remove the item from the list
    setState(() {
      cashFlowData.removeAt(index);
    });
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
                "Detail Cash Flow",
                style: TextStyle(
                  fontSize: 24, // Membesarkan ukuran font
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cashFlowData.length,
                itemBuilder: (context, index) {
                  final item = cashFlowData[index];
                  final isIncome = item.type == incomeType;

                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: ListTile(
                      tileColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      leading: Icon(
                        isIncome
                            ? Icons.arrow_forward_ios
                            : Icons.arrow_back_ios,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rp ${item.amount}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8), // Memberikan space antar baris
                          Text(
                            "Deskripsi: ${item.description}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8), // Memberikan space antar baris
                          Text(
                            item.date!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () async {
                          _deleteItem(index);
                        },
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
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
                child: const Text(
                  "<< Kembali",
                  style: TextStyle(fontSize: 18), // Membesarkan ukuran font
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
