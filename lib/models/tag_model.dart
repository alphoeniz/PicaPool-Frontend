import 'package:picapool/models/offer_model.dart';
import 'package:picapool/models/partner_model.dart';
import 'package:picapool/models/user_model.dart';

class Tag {
  final int id;
  final String tag;
  final String icon;
  final List<Offer>? offers;
  final List<User>? users;
  final List<Partner>? partners;

  Tag({
    required this.id,
    required this.tag,
    required this.icon,
    this.offers,
    this.users,
    this.partners,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      tag: json['tag'],
      icon: json['icon'],
      offers: json['offers'] != null
          ? (json['offers'] as List).map((o) => Offer.fromJson(o)).toList()
          : null,
      users: json['users'] != null
          ? (json['users'] as List).map((u) => User.fromJson(u)).toList()
          : null,
      partners: json['partners'] != null
          ? (json['partners'] as List).map((p) => Partner.fromJson(p)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag': tag,
      'icon': icon,
      'offers': offers?.map((o) => o.toJson()).toList(),
      'users': users?.map((u) => u.toJson()).toList(),
      'partners': partners?.map((p) => p.toJson()).toList(),
    };
  }
}
