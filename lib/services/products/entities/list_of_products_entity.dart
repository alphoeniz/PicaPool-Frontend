import 'package:picapool/services/products/entities/product_entity.dart';

class ProductsList {
  List<Product> productsList;
  int count;
  ProductsList({
    required this.productsList,
    required this.count,
  });

  factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
        productsList:
            List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        count: List<Product>.from(json["data"].map((x) => Product.fromJson(x))).length,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(productsList.map((x) => x.toJson())),
        "count": count,
       
      };
}
