// To parse this JSON data, do
//
//     final updateCategoryPayload = updateCategoryPayloadFromJson(jsonString);

import 'dart:convert';

UpdateCategoryPayload updateCategoryPayloadFromJson(String str) => UpdateCategoryPayload.fromJson(json.decode(str));

String updateCategoryPayloadToJson(UpdateCategoryPayload data) => json.encode(data.toJson());

class UpdateCategoryPayload {
    int? id;
    String? name;
    String? pic;

    UpdateCategoryPayload({
        this.id,
        this.name,
        this.pic,
    });

    factory UpdateCategoryPayload.fromJson(Map<String, dynamic> json) => UpdateCategoryPayload(
        id: json["id"],
        name: json["name"],
        pic: json["pic"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pic": pic,
    };
}
