import 'package:flutter/material.dart';
import 'package:gerai_lam_supplier/models/product_model.dart';

import '../theme.dart';

class CatalogWidget extends StatelessWidget {
  Function? onTap;
  ProductModel? product;
  CatalogWidget({Key? key, this.onTap, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: 150,
        height: 243,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: cartColor,
                offset: Offset(4, 4),
                spreadRadius: 4,
                blurRadius: 4,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 131,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(product!.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 7),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product!.name!,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: primaryText.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Rp. ${product!.price!.toString()}',
                    style: primaryText.copyWith(
                      color: primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "STOK ${product!.stok!.toString()}",
                        style: primaryText.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
