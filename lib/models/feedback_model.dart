import 'package:picapool/models/user_model.dart';

class Feedback {
  final int id;
  final String? feedback;
  final User? user;
  final int? userId;

  Feedback({
    required this.id,
    this.feedback,
    this.user,
    this.userId,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['id'],
      feedback: json['feedback'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feedback': feedback,
      'user': user?.toJson(),
      'userId': userId,
    };
  }
}
