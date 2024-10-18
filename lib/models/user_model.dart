import 'package:picapool/models/auth_model.dart';
import 'package:picapool/models/chat_model.dart';
import 'package:picapool/models/feedback_model.dart';
import 'package:picapool/models/live_offer_model.dart';
import 'package:picapool/models/message_model.dart';
import 'package:picapool/models/offer_model.dart';
import 'package:picapool/models/reaction_model.dart';
import 'package:picapool/models/tag_model.dart';

class User {
  final int id;
  String? name;
  String? pic;
  String? bio;
  String? location; // You might need to handle Point separately
  String? fcmToken;
  final DateTime createdAt;
  DateTime updatedAt;
  final Auth? auth; // Assuming Auth is another model
  final int? authId;
  List<Feedback>? feedback;
  List<Chat>? chats;
  List<Message>? messages;
  List<Offer>? offers;
  List<Reaction>? reactions;
  List<Tag>? tags;
  List<LiveOffer>? liveOffers;

  User({
    required this.id,
    this.name,
    this.pic,
    this.bio,
    this.location,
    this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    this.auth,
    this.authId,
    this.feedback,
    this.chats,
    this.messages,
    this.offers,
    this.reactions,
    this.tags,
    this.liveOffers,
  });

  // Example of a factory constructor for converting from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      pic: json['pic'],
      bio: json['bio'],
      location: json['location'],
      fcmToken: json['fcmToken'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      auth: json['auth'] != null ? Auth.fromJson(json['auth']) : null,
      authId: json['authId'],
      feedback: (json['feedback'] as List?)
          ?.map((e) => Feedback.fromJson(e))
          .toList(),
      chats: (json['chats'] as List?)?.map((e) => Chat.fromJson(e)).toList(),
      messages:
          (json['messages'] as List?)?.map((e) => Message.fromJson(e)).toList(),
      offers: (json['offers'] as List?)?.map((e) => Offer.fromJson(e)).toList(),
      reactions: (json['reactions'] as List?)
          ?.map((e) => Reaction.fromJson(e))
          .toList(),
      tags: (json['tags'] as List?)?.map((e) => Tag.fromJson(e)).toList(),
      liveOffers: (json['liveOffers'] as List?)
          ?.map((e) => LiveOffer.fromJson(e))
          .toList(),
    );
  }

  // Example of a method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pic': pic,
      'bio': bio,
      'location': location,
      'fcmToken': fcmToken,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'auth': auth?.toJson(),
      'authId': authId,
      'feedback': feedback?.map((e) => e.toJson()).toList(),
      'chats': chats?.map((e) => e.toJson()).toList(),
      'messages': messages?.map((e) => e.toJson()).toList(),
      'offers': offers?.map((e) => e.toJson()).toList(),
      'reactions': reactions?.map((e) => e.toJson()).toList(),
      'tags': tags?.map((e) => e.toJson()).toList(),
      'liveOffers': liveOffers?.map((e) => e.toJson()).toList(),
    };
  }

  // Update method to modify certain fields
  void update(Map<String, dynamic> fields) {
    name = fields['name'] ?? name;
    pic = fields['pic'] ?? pic;
    bio = fields['bio'] ?? bio;
    location = fields['location'] ?? location;
    fcmToken = fields['fcmToken'] ?? fcmToken;
    feedback = fields['feedback'] != null
        ? (fields['feedback'] as List).map((e) => Feedback.fromJson(e)).toList()
        : feedback;
    chats = fields['chats'] != null
        ? (fields['chats'] as List).map((e) => Chat.fromJson(e)).toList()
        : chats;
    messages = fields['messages'] != null
        ? (fields['messages'] as List).map((e) => Message.fromJson(e)).toList()
        : messages;
    offers = fields['offers'] != null
        ? (fields['offers'] as List).map((e) => Offer.fromJson(e)).toList()
        : offers;
    reactions = fields['reactions'] != null
        ? (fields['reactions'] as List)
            .map((e) => Reaction.fromJson(e))
            .toList()
        : reactions;
    tags = fields['tags'] != null
        ? (fields['tags'] as List).map((e) => Tag.fromJson(e)).toList()
        : tags;
    liveOffers = fields['liveOffers'] != null
        ? (fields['liveOffers'] as List)
            .map((e) => LiveOffer.fromJson(e))
            .toList()
        : liveOffers;
    updatedAt = DateTime.now();
  }
}
