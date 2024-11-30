import 'package:picapool/models/auth_model.dart';
import 'package:picapool/models/chat_model.dart';
import 'package:picapool/models/message_model.dart';
import 'package:picapool/models/reaction_model.dart';

class Admin {
  final int id;
  final String? name;
  final String? pic;
  final String? fcmToken;
  final Auth? auth;
  final int? authId;
  final List<Chat>? chats;
  final List<Message>? messages;
  final List<Reaction>? reactions;

  Admin({
    required this.id,
    this.name,
    this.pic,
    this.fcmToken,
    this.auth,
    this.authId,
    this.chats,
    this.messages,
    this.reactions,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      name: json['name'],
      pic: json['pic'],
      fcmToken: json['fcmToken'],
      auth: json['auth'] != null ? Auth.fromJson(json['auth']) : null,
      authId: json['authId'],
      chats: json['chats'] != null
          ? (json['chats'] as List).map((c) => Chat.fromJson(c)).toList()
          : null,
      messages: json['messages'] != null
          ? (json['messages'] as List).map((m) => Message.fromJson(m)).toList()
          : null,
      reactions: json['reactions'] != null
          ? (json['reactions'] as List)
              .map((r) => Reaction.fromJson(r))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pic': pic,
      'fcmToken': fcmToken,
      'auth': auth?.toJson(),
      'authId': authId,
      'chats': chats?.map((c) => c.toJson()).toList(),
      'messages': messages?.map((m) => m.toJson()).toList(),
      'reactions': reactions?.map((r) => r.toJson()).toList(),
    };
  }
}
