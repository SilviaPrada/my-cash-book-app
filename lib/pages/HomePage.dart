import 'package:my_cash_book/constant/route_constants.dart';
import 'package:my_cash_book/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    final dbHelper = DbHelper();

    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalExpense();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          // Add this
          child: Column(// Remove the Center widget
              children: [
            Text(
              "Rangkuman Bulan Ini",
              style: TextStyle(
                fontSize: 24, // Membesarkan ukuran teks
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Total Pengeluaran: \Rp $totalExpense",
              style: TextStyle(
                fontSize: 18, // Membesarkan ukuran teks
                color: Colors.red, // Mengatur warna teks menjadi merah
              ),
            ),
            Text(
              "Total Pemasukan: \Rp $totalIncome",
              style: TextStyle(
                fontSize: 18, // Membesarkan ukuran teks
                color: Colors.green, // Mengatur warna teks menjadi hijau
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: LineChart(LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                minX: 0,
                maxX: 7,
                minY: 0,
                maxY: 1000,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 200),
                      FlSpot(1, 150),
                      FlSpot(2, 450),
                      FlSpot(3, 300),
                      FlSpot(4, 600),
                      FlSpot(5, 500),
                      FlSpot(6, 800),
                      FlSpot(7, 1000),
                    ],
                    isCurved: false, // Make the line sharp instead of round
                    color: Colors.green,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                    barWidth: 5, // Adjust the thickness of the line
                  ),
                ],
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFF09A1A),
                                width: 1), // Add border
                            borderRadius: BorderRadius.circular(20)),
                        child: NavButton(
                          imagePath: 'assets/images/income.png',
                          label: "Tambah Pemasukan",
                          onTap: () {
                            Navigator.pushNamed(context, addIncomeRoute);
                          },
                          labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold), // Increase label size
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFF09A1A),
                                width: 1), // Add border
                            borderRadius: BorderRadius.circular(20)),
                        child: NavButton(
                          imagePath: 'assets/images/expense.png',
                          label: "Tambah Pengeluaran",
                          onTap: () {
                            Navigator.pushNamed(context, addExpenseRoute);
                          },
                          labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold), // Increase label size
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFF09A1A),
                                width: 1), // Add border
                            borderRadius: BorderRadius.circular(20)),
                        child: NavButton(
                          imagePath: 'assets/images/lists.png',
                          label: "Detail Cash Flow",
                          onTap: () {
                            Navigator.pushNamed(context, detailCashFlowRoute);
                          },
                          labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold), // Increase label size
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFF09A1A),
                                width: 1), // Add border
                            borderRadius: BorderRadius.circular(20)),
                        child: NavButton(
                          imagePath: 'assets/images/settings.png',
                          label: "Pengaturan",
                          onTap: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold), // Increase label size
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;
  final TextStyle labelStyle;

  const NavButton({
    required this.imagePath,
    required this.label,
    required this.onTap,
    this.labelStyle = const TextStyle(fontSize: 16),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: labelStyle,
          ),
        ],
      ),
    );
  }
}
