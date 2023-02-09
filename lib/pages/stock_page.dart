import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerai_lam_supplier/theme.dart';
import 'package:intl/intl.dart';

import 'detail_stock_page.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  List<DateTime> dates = [];
  List _daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  DateTime date = DateTime.now();
  int filterMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    dates = List.generate(
        3, (index) => DateTime(date.year, date.month - index + 1, 0));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference stocks = FirebaseFirestore.instance.collection('stock');

    return SafeArea(
      child: ListView(
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                    stream: stocks
                        .orderBy("date_in", descending: true)
                        .where("date_in",
                            isGreaterThanOrEqualTo:
                                DateTime(date.year, filterMonth, 1))
                        .where("date_in",
                            isLessThan: DateTime(date.year, filterMonth,
                                _daysInMonth[filterMonth] + 1))
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(
                          "${date.year}, ${filterMonth}, ${_daysInMonth[filterMonth]}");
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!.docs.map((doc) {
                            Map<String, dynamic> stock =
                                doc.data() as Map<String, dynamic>;

                            String tglMasuk = DateFormat('dd MMMM yyyy').format(
                                (stock['date_in'] as Timestamp).toDate());

                            String waktuMasuk = DateFormat('h:mm a').format(
                                (stock['time_in'] as Timestamp).toDate());

                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailStockPage(
                                        stokModel: stock,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  title: Text("${tglMasuk}, ${waktuMasuk}"),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Masuk : ${stock['stock_in'].length} Barang"),
                                          Text(
                                              "Return : ${stock['stock_return'].length} Barang"),
                                        ],
                                      ),
                                      Chip(
                                        label: Text(
                                          "Selesai",
                                          style: primaryText.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: greenColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        print("tak ada");
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            "Stock",
            style: primaryText.copyWith(fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: dates
                .map(
                  (e) => FilterChip(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      selectedColor: filterMonth == e.month
                          ? primaryColor
                          : Colors.transparent,
                      selected: filterMonth == e.month,
                      label: Text(
                        DateFormat('MMM yy').format(DateTime(e.year, e.month)),
                      ),
                      onSelected: (value) {
                        setState(() {
                          filterMonth = e.month;
                        });
                        print(e.month.toString() + date.year.toString());
                      }),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
