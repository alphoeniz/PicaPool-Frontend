// To parse this JSON data, do
//
//     final createCategoryResponse = createCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:picapool/services/categories/entities/category_entity.dart';

CreateCategoryResponse createCategoryResponseFromJson(String str) => CreateCategoryResponse.fromJson(json.decode(str));

String createCategoryResponseToJson(CreateCategoryResponse data) => json.encode(data.toJson());

class CreateCategoryResponse {
    bool? success;
    Category? data;
    String? message;

    CreateCategoryResponse({
        this.success,
        this.data,
        this.message,
    });

    factory CreateCategoryResponse.fromJson(Map<String, dynamic> json) => CreateCategoryResponse(
        success: json["success"],
        data: json["data"] == null ? null : Category.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
    };
}


