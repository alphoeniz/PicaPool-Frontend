// To parse this JSON data, do
//
//     final createProductPayload = createProductPayloadFromJson(jsonString);

import 'dart:convert';

CreateProductPayload createProductPayloadFromJson(String str) => CreateProductPayload.fromJson(json.decode(str));

String createProductPayloadToJson(CreateProductPayload data) => json.encode(data.toJson());

class CreateProductPayload {
    String? name;
    List<String>? pic;
    int? price;
    int? offerPriceMin;
    int? offerPriceMax;
    int? partner;
    int? category;
    String? deviceType;
    String? modelName;
    String? brand;
    String? description;
    String? accessories;
    String? condition;
    String? style;
    String? fabric;
    String? size;
    String? author;
    String? genre;
    String? type;
    String? material;
    String? height;
    String? length;
    String? breadth;
    int? year;
    int? kmsDriven;
    String? specifications;
    int? timeHeldYears;
    int? timeHeldMonths;
    String? reasonForSell;
    String? phone;
    String? email;

    CreateProductPayload({
        this.name,
        this.pic,
        this.price,
        this.offerPriceMin,
        this.offerPriceMax,
        this.partner,
        this.category,
        this.deviceType,
        this.modelName,
        this.brand,
        this.description,
        this.accessories,
        this.condition,
        this.style,
        this.fabric,
        this.size,
        this.author,
        this.genre,
        this.type,
        this.material,
        this.height,
        this.length,
        this.breadth,
        this.year,
        this.kmsDriven,
        this.specifications,
        this.timeHeldYears,
        this.timeHeldMonths,
        this.reasonForSell,
        this.phone,
        this.email,
    });

    factory CreateProductPayload.fromJson(Map<String, dynamic> json) => CreateProductPayload(
        name: json["name"],
        pic: json["pic"] == null ? [] : List<String>.from(json["pic"]!.map((x) => x)),
        price: json["price"],
        offerPriceMin: json["offerPriceMin"],
        offerPriceMax: json["offerPriceMax"],
        partner: json["partner"],
        category: json["category"],
        deviceType: json["deviceType"],
        modelName: json["modelName"],
        brand: json["brand"],
        description: json["description"],
        accessories: json["accessories"],
        condition: json["condition"],
        style: json["style"],
        fabric: json["fabric"],
        size: json["size"],
        author: json["author"],
        genre: json["genre"],
        type: json["type"],
        material: json["material"],
        height: json["height"],
        length: json["length"],
        breadth: json["breadth"],
        year: json["year"],
        kmsDriven: json["kmsDriven"],
        specifications: json["specifications"],
        timeHeldYears: json["timeHeldYears"],
        timeHeldMonths: json["timeHeldMonths"],
        reasonForSell: json["reasonForSell"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "pic": pic == null ? [] : List<dynamic>.from(pic!.map((x) => x)),
        "price": price,
        "offerPriceMin": offerPriceMin,
        "offerPriceMax": offerPriceMax,
        "partner": partner,
        "category": category,
        "deviceType": deviceType,
        "modelName": modelName,
        "brand": brand,
        "description": description,
        "accessories": accessories,
        "condition": condition,
        "style": style,
        "fabric": fabric,
        "size": size,
        "author": author,
        "genre": genre,
        "type": type,
        "material": material,
        "height": height,
        "length": length,
        "breadth": breadth,
        "year": year,
        "kmsDriven": kmsDriven,
        "specifications": specifications,
        "timeHeldYears": timeHeldYears,
        "timeHeldMonths": timeHeldMonths,
        "reasonForSell": reasonForSell,
        "phone": phone,
        "email": email,
    };
}
