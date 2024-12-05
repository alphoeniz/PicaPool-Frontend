import 'package:picapool/models/auth_model.dart';
import 'package:picapool/models/offer_model.dart';
import 'package:picapool/models/product_model.dart';
import 'package:picapool/models/tag_model.dart';

class Partner {
  final int id;
  final String? name;
  final String? pic;
  final String? location;
  final Auth? auth;
  final int? authId;
  final List<Offer>? offers;
  final List<Tag>? tags;
  final List<Product>? products;

  Partner({
    required this.id,
    this.name,
    this.pic,
    this.location,
    this.auth,
    this.authId,
    this.offers,
    this.tags,
    this.products,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      name: json['name'],
      pic: json['pic'],
      location: json['location'],
      auth: json['auth'] != null ? Auth.fromJson(json['auth']) : null,
      authId: json['authId'],
      offers: json['offers'] != null
          ? (json['offers'] as List).map((o) => Offer.fromJson(o)).toList()
          : null,
      tags: json['tags'] != null
          ? (json['tags'] as List).map((t) => Tag.fromJson(t)).toList()
          : null,
      products: json['products'] != null
          ? (json['products'] as List).map((p) => Product.fromJson(p)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pic': pic,
      'location': location,
      'auth': auth?.toJson(),
      'authId': authId,
      'offers': offers?.map((o) => o.toJson()).toList(),
      'tags': tags?.map((t) => t.toJson()).toList(),
      'products': products?.map((p) => p.toJson()).toList(),
    };
  }
}
