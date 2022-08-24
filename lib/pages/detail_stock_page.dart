import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerai_lam_supplier/theme.dart';
import 'package:intl/intl.dart';

class DetailStockPage extends StatelessWidget {
  Map<String, dynamic>? stokModel;
  DetailStockPage({Key? key, this.stokModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String tglMasuk = DateFormat('dd MMMM yyyy')
        .format((stokModel!['date_in'] as Timestamp).toDate());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail Stock',
          style: primaryText.copyWith(color: Colors.black),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Data Stok Masuk",
                        style: primaryText.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No Faktur :",
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "${stokModel!['noFaktur']}",
                          style: primaryText,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal :",
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "${tglMasuk}",
                          style: primaryText.copyWith(),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jam :",
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "${stokModel!['time_in'].toString().substring(10, 15)}",
                          style: primaryText.copyWith(),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Supplier :",
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "${stokModel!['supplier']['nama']}",
                          style: primaryText.copyWith(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Stok Masuk :",
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: stokModel!['stock_in']
                              .map<Widget>(
                                (stockss) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        '${stockss!['nama']}',
                                        style: primaryText,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              NumberFormat.currency(
                                                      name: 'Rp. ',
                                                      decimalDigits: 0)
                                                  .format(stockss!['harga']),
                                              style: primaryText,
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      name: 'Rp. ',
                                                      decimalDigits: 0)
                                                  .format(
                                                      stockss!['harga_jual']),
                                              style: primaryText,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${stockss!['stok']}',
                                          style: primaryText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Stok Return :",
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: stokModel!['stock_return']
                              .map<Widget>(
                                (stockss) => Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        '${stockss!['nama']}',
                                        style: primaryText,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              NumberFormat.currency(
                                                      name: 'Rp. ',
                                                      decimalDigits: 0)
                                                  .format(stockss!['harga']),
                                              style: primaryText,
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      name: 'Rp. ',
                                                      decimalDigits: 0)
                                                  .format(
                                                      stockss!['harga_jual']),
                                              style: primaryText,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${stockss!['stok']}',
                                          style: primaryText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deskripsi :",
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Text(
                            "${stokModel!['description']}",
                            style: primaryText,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "KEMBALI",
                  style: primaryText.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
