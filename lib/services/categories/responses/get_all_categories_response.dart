// To parse this JSON data, do
//
//     final getAllCategoriesResponse = getAllCategoriesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:picapool/services/categories/entities/category_entity.dart';

GetAllCategoriesResponse getAllCategoriesResponseFromJson(String str) => GetAllCategoriesResponse.fromJson(json.decode(str));

String getAllCategoriesResponseToJson(GetAllCategoriesResponse data) => json.encode(data.toJson());

class GetAllCategoriesResponse {
    bool? success;
    List<Category>? data;
    String? message;

    GetAllCategoriesResponse({
        this.success,
        this.data,
        this.message,
    });

    factory GetAllCategoriesResponse.fromJson(Map<String, dynamic> json) => GetAllCategoriesResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}