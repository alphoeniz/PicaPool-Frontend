class Vehicle {
  final int id;
  final String name;
  final String pic;
  final String type;
  final String licenseNumber;

  Vehicle({
    required this.id,
    required this.name,
    required this.pic,
    required this.type,
    required this.licenseNumber,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      pic: json['pic'],
      type: json['type'],
      licenseNumber: json['licenseNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pic': pic,
      'type': type,
      'licenseNumber': licenseNumber,
    };
  }
}
