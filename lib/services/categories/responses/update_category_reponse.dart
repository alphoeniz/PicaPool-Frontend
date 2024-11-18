// To parse this JSON data, do
//
//     final updateCategoryResponse = updateCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:picapool/services/categories/entities/category_entity.dart';

UpdateCategoryResponse updateCategoryResponseFromJson(String str) => UpdateCategoryResponse.fromJson(json.decode(str));

String updateCategoryResponseToJson(UpdateCategoryResponse data) => json.encode(data.toJson());

class UpdateCategoryResponse {
    bool? success;
    Category? data;
    String? message;

    UpdateCategoryResponse({
        this.success,
        this.data,
        this.message,
    });

    factory UpdateCategoryResponse.fromJson(Map<String, dynamic> json) => UpdateCategoryResponse(
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

