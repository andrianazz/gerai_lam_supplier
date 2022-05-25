import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerai_lam_supplier/models/product_model.dart';
import 'package:gerai_lam_supplier/pages/detail_product_page.dart';
import 'package:gerai_lam_supplier/widgets/catalog_widget.dart';

import '../theme.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
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
                SizedBox(height: 20),
                Text(
                  "Katalog Barang",
                  style: primaryText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: mockProduct
                      .map((product) => CatalogWidget(
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
                          ))
                      .toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
