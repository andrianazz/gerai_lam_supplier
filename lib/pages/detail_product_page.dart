import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme.dart';

class DetailProductPage extends StatelessWidget {
  ProductModel? product;
  DetailProductPage({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          image(),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.favorite_border,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          content(context),
        ],
      ),
    );
  }

  Widget image() {
    return Container(
      width: double.infinity,
      height: 326,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(product!.imageUrl!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget content(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 300,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Tag
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    product!.name!,
                    style: primaryText.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Rp ${product!.price.toString()}',
                      style: primaryText.copyWith(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      children: [
                        TextSpan(
                          text: '/ kg',
                          style: primaryText.copyWith(
                            fontSize: 14,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Deskripsi",
                            style: primaryText.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 81,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: greyColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    product!.description!,
                    style: primaryText.copyWith(fontSize: 13),
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 38,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Informasi Jumlah",
                      style: primaryText.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 145,
                        height: 109,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Barang Masuk",
                              style: primaryText.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "400",
                              style: primaryText.copyWith(
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 145,
                        height: 109,
                        decoration: BoxDecoration(
                          color: secondaryRedColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: redColor,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Barang Keluar",
                              style: primaryText.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: redColor,
                              ),
                            ),
                            Text(
                              "75",
                              style: primaryText.copyWith(
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: redColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "STOK TERSISA",
                        style: primaryText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${product!.stok!.toString()}",
                        style: primaryText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
