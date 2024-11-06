class ResponseModel {
  final String message;
  final bool success;
  final dynamic data;

  ResponseModel({
    required this.message,
    required this.success,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'],
      success: json['success'],
      data: json['data'],
    );
  }
}
