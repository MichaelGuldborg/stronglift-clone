// import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  final String? id;
  final String? type;
  final String? title;
  final String? body;
  final DateTime? createdAt;

  PushNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  static PushNotification serializer(dynamic map) {
    return PushNotification.fromAPI(map);
  }

  factory PushNotification.fromAPI(Map<String, dynamic> map) {
    return PushNotification(
      id: map['id'],
      type: '',
      title: map['title'],
      body: map['body'],
      createdAt: map['createdAt'],
    );
  }

  factory PushNotification.fromRemoteMessage(dynamic message) {
    return PushNotification(
      id: message.messageId,
      type: message.messageType,
      title: message.notification?.title,
      body: message.notification?.body,
      createdAt: message.sentTime,
      // data: Map<String, dynamic>.from(message.data),
    );
  }

  factory PushNotification.fromMap(Map<String, dynamic> map) {
    return PushNotification(
      id: map['id'],
      type: map['type'],
      title: map['title'],
      body: map['body'],
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'title': title,
      'body': body,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
