import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction_model.dart';
import '../theme.dart';

class SalesPage extends StatefulWidget {
  SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getAll();
  }

  String? idSupplier;

  Future<void> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    setState(() {
      idSupplier = id;
      print(idSupplier);
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference transactions = firestore.collection('transactions');

    String noImage =
        "https://sin1.contabostorage.com/ecf04223836c4aec8b37f36b5caf97be:galeri-lam-riau/assets/no-image.png";

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
                    stream: transactions
                        .orderBy('tanggal', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!.docs.map((doc) {
                            TransactionModel transaction =
                                TransactionModel.fromJson(
                                    doc.data() as Map<String, dynamic>);

                            String tanggal = DateFormat('dd MMMM yyyy HH:mm')
                                .format(transaction.date as DateTime);

                            return Column(
                              children: transaction.items!.map((item) {
                                if (item.idSupplier == idSupplier) {
                                  return Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          item.imageUrl == null
                                              ? noImage
                                              : item.imageUrl.toString(),
                                        ),
                                      ),
                                      title: Container(
                                        width: 150,
                                        child: Text(
                                          item.name.toString(),
                                          style: primaryText,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(tanggal),
                                          SizedBox(height: 10),
                                          Text(
                                            '${item.quantity.toString()} items',
                                            style: primaryText.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: redColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }).toList(),
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
          ),
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
            "Penjualan",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
