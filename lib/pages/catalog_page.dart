import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerai_lam_supplier/models/product_model.dart';
import 'package:gerai_lam_supplier/pages/detail_product_page.dart';
import 'package:gerai_lam_supplier/widgets/catalog_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class CatalogPage extends StatefulWidget {
  CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getId();
  }

  String idSupplier = '';

  Future<void> getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id") ?? '';

    setState(() {
      idSupplier = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference products = firestore.collection('product');
    return SafeArea(
      child: ListView(
        children: [
          SizedBox(height: 20),
          header(),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      fillColor: searchColor,
                      filled: true,
                      hintText: 'Search for fruits and vegetables',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                ),
                SizedBox(height: 30),
                StreamBuilder<QuerySnapshot>(
                    stream: products
                        .where('supplier.id', isEqualTo: idSupplier)
                        .orderBy('nama')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          alignment: WrapAlignment.center,
                          children: snapshot.data!.docs.map((e) {
                            ProductModel product = ProductModel.fromJson(
                                e.data() as Map<String, dynamic>);

                            return CatalogWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProductPage(
                                      product: product,
                                    ),
                                  ),
                                );
                              },
                              product: product,
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
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
            "Katalog Barang",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
