// To parse this JSON data, do
//
//     final getAllProductsResponse = getAllProductsResponseFromJson(jsonString);

import 'dart:convert';

import '../entities/product_entity.dart';

GetAllProductsResponse getAllProductsResponseFromJson(String str) => GetAllProductsResponse.fromJson(json.decode(str));

String getAllProductsResponseToJson(GetAllProductsResponse data) => json.encode(data.toJson());

class GetAllProductsResponse {
    bool? success;
    List<Product>? data;
    String? message;

    GetAllProductsResponse({
        this.success,
        this.data,
        this.message,
    });

    factory GetAllProductsResponse.fromJson(Map<String, dynamic> json) => GetAllProductsResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

