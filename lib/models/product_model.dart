import 'package:picapool/models/offer_model.dart';
import 'package:picapool/models/partner_model.dart';

class Product {
  final int id;
  final String name;
  final String pic;
  final int price;
  final int offerPriceMin;
  final int offerPriceMax;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Partner partner;
  final int partnerId;
  final List<Offer>? offers;

  Product({
    required this.id,
    required this.name,
    required this.pic,
    required this.price,
    required this.offerPriceMin,
    required this.offerPriceMax,
    required this.createdAt,
    required this.updatedAt,
    required this.partner,
    required this.partnerId,
    this.offers,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      pic: json['pic'],
      price: json['price'],
      offerPriceMin: json['offerPriceMin'],
      offerPriceMax: json['offerPriceMax'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      partner: Partner.fromJson(json['partner']),
      partnerId: json['partnerId'],
      offers: json['offers'] != null
          ? (json['offers'] as List).map((o) => Offer.fromJson(o)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pic': pic,
      'price': price,
      'offerPriceMin': offerPriceMin,
      'offerPriceMax': offerPriceMax,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'partner': partner.toJson(),
      'partnerId': partnerId,
      'offers': offers?.map((o) => o.toJson()).toList(),
    };
  }
}
