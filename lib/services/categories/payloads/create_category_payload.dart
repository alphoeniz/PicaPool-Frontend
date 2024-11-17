// To parse this JSON data, do
//
//     final createCategoryPayload = createCategoryPayloadFromJson(jsonString);

import 'dart:convert';

CreateCategoryPayload createCategoryPayloadFromJson(String str) => CreateCategoryPayload.fromJson(json.decode(str));

String createCategoryPayloadToJson(CreateCategoryPayload data) => json.encode(data.toJson());

class CreateCategoryPayload {
    String? name;
    String? pic;

    CreateCategoryPayload({
        this.name,
        this.pic,
    });

    factory CreateCategoryPayload.fromJson(Map<String, dynamic> json) => CreateCategoryPayload(
        name: json["name"],
        pic: json["pic"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "pic": pic,
    };
}
