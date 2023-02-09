import 'package:gerai_lam_supplier/models/stock_in_model.dart';
import 'package:gerai_lam_supplier/models/stock_return_model.dart';

class StockModel {
  String? noFaktur;
  String? supplier;
  DateTime? dateIn;
  DateTime? timeIn;
  List<StockInModel>? stockIn;
  List<StockReturnModel>? stockReturn;
  String? description;

  StockModel({
    this.noFaktur,
    this.supplier,
    this.dateIn,
    this.timeIn,
    this.stockIn,
    this.stockReturn,
    this.description,
  });

  StockModel.fromJson(Map<String, dynamic> json) {
    noFaktur = json['noFaktur'];
    supplier = json['supplier']['nama'];
    dateIn = json['date_in'].toDate();
    timeIn = json['time_in'].toDate();
    stockIn = json['stock_in']!
        .map<StockInModel>((stockData) => StockInModel.fromJson(stockData))
        .toList;
    stockReturn = json['stock_return']!
        .map<StockReturnModel>(
            (stockData) => StockReturnModel.fromJson(stockData))
        .toList;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'noFaktur': noFaktur,
      'supplier': supplier,
      'date_in': dateIn.toString(),
      'time_in': timeIn.toString(),
      'stock_in': stockIn?.map((stockData) => StockInModel().toJson()).toList(),
      'stock_return':
          stockReturn?.map((stockData) => StockReturnModel().toJson()).toList(),
      'description': description,
    };
  }
}
