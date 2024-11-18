class VicinityOffer {
  final String name;
  final int category;
  final int brand;
  final List<String> images;
  final String desc;
  final DateTime expiryAt;
  final int creatorID;
  final List<String> products;
  final List<String> productsMRP;
  final List<String> productsOfferPrice;

  VicinityOffer({
    required this.name,
    this.category = 0,
    this.brand = 0,
    required this.images,
    required this.desc,
    required this.expiryAt,
    required this.creatorID,
    this.products = const [],
    this.productsMRP = const [],
    this.productsOfferPrice = const [],
  });

  factory VicinityOffer.fromJson(Map<String, dynamic> json) {
    return VicinityOffer(
      name: json['name'],
      category: json['category'],
      brand: json['brand'],
      images: List<String>.from(json['images']),
      desc: json['desc'],
      expiryAt: DateTime.parse(json['expiryAt']),
      creatorID: json['creatorID'],
      products: List<String>.from(json['products']),
      productsMRP: List<String>.from(json['productsMRP']),
      productsOfferPrice: List<String>.from(json['productsOfferPrice']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'brand': brand,
      'images': images,
      'desc': desc,
      'expiryAt': expiryAt.toUtc().toIso8601String(),
      'creatorID': creatorID,
      'products': products,
      'productsMRP': productsMRP,
      'productsOfferPrice': productsOfferPrice,
    };
  }
}
