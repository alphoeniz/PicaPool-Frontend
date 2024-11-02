import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:picapool/functions/auth/auth_controller.dart';
import 'package:picapool/models/admin_model.dart';
import 'package:picapool/models/live_product_model.dart';
import 'package:picapool/models/partner_model.dart';
import 'package:picapool/models/role_model.dart';
import 'package:picapool/models/user_model.dart';

class Auth {
  // final int id;
  final String? googleSub;
  final String? appleSub;
  final String? mobile;
  final String? refreshToken;
  final String? accessToken;
  final Admin? admin;
  final Partner? partner;
  User? user;
  final LivePartner? livePartner;
  final List<Role>? roles;
  final bool? isNew;
  final bool? isGuest;

  Auth({
    // required this.id,
    this.googleSub,
    this.appleSub,
    this.mobile,
    this.refreshToken,
    this.admin,
    this.partner,
    this.user,
    this.livePartner,
    this.roles,
    this.isNew,
    this.isGuest,
    this.accessToken,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    debugPrint("Auth.fromJson: $json");
    return Auth(
      // id: json['id'],
      googleSub: json['googleSub'],
      appleSub: json['appleSub'],
      mobile: json['mobile'],
      refreshToken: json['refreshToken'],
      admin: json['admin'] != null ? Admin.fromJson(json['admin']) : null,
      partner:
          json['partner'] != null ? Partner.fromJson(json['partner']) : null,
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : _getUserFromAccessToken(json['accessToken']),
      livePartner: json['livePartner'] != null
          ? LivePartner.fromJson(json['livePartner'])
          : null,
      roles: json['roles'] != null
          ? (json['roles'] as List).map((role) => Role.fromJson(role)).toList()
          : null,
      isNew: json['isNew'],
      isGuest: json['isGuest'],
      accessToken: json['accessToken'],
    );
  }

  static User _getUserFromAccessToken(String accessToken) {
    var jwt = Token.decode(accessToken);
    var user = User(
      id: jwt['tenant']['id'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(jwt['iat']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(jwt['exp']),
      authId: jwt['authId'],
    );
    debugPrint(
      "User created At: ${user.createdAt} and Updated At: ${user.updatedAt}",
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'googleSub': googleSub,
      'appleSub': appleSub,
      'mobile': mobile,
      'refreshToken': refreshToken,
      'admin': admin?.toJson(),
      'partner': partner?.toJson(),
      'user': user?.toJson(),
      'livePartner': livePartner?.toJson(),
      'isNew': isNew,
      'roles': roles?.map((role) => role.toJson()).toList(),
      'isGuest': isGuest,
      'accessToken': accessToken,
    };
  }

  Auth copyWith({
    String? googleSub,
    String? appleSub,
    String? mobile,
    String? refreshToken,
    String? accessToken,
    Admin? admin,
    Partner? partner,
    User? user,
    LivePartner? livePartner,
    List<Role>? roles,
    bool? isNew,
    bool? isGuest,
  }) {
    return Auth(
      googleSub: googleSub ?? this.googleSub,
      appleSub: appleSub ?? this.appleSub,
      mobile: mobile ?? this.mobile,
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
      admin: admin ?? this.admin,
      partner: partner ?? this.partner,
      user: user ?? this.user,
      livePartner: livePartner ?? this.livePartner,
      roles: roles ?? this.roles,
      isNew: isNew ?? this.isNew,
      isGuest: isGuest ?? this.isGuest,
    );
  }
}

class Token {
  static Map<String, dynamic> decode(String token) {
    return JwtDecoder.decode(token);
  }
}
