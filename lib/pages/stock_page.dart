import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerai_lam_supplier/pages/detail_stock_page.dart';
import 'package:gerai_lam_supplier/theme.dart';
import 'package:intl/intl.dart';

class StockPage extends StatelessWidget {
  const StockPage({Key? key}) : super(key: key);

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
                    stream: stocks.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!.docs.map((doc) {
                            Map<String, dynamic> stock =
                                doc.data() as Map<String, dynamic>;
                            String tglMasuk = DateFormat('dd MMMM yyyy').format(
                                (stock['date_in'] as Timestamp).toDate());

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
                                  title: Text(
                                      "${tglMasuk}, ${stock['time_in'].toString().substring(10, 15)}"),
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
      child: Row(
        children: [
          Text(
            "Stock",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
