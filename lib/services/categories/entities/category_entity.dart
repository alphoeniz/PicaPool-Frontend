class Category {
    int? id;
    String? pic;
    String? name;

    Category({
        this.id,
        this.pic,
        this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        pic: json["pic"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pic": pic,
        "name": name,
    };
}
