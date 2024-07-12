import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../domain/entity/push_notifications/push_message.dart';

class PushMessageModel extends PushMessage {
  const PushMessageModel({
    required super.messageId,
    required super.title,
    required super.body,
    required super.sendDate,
    required super.notificationMessageType,
    super.data,
    super.imageUrl,
  });

  factory PushMessageModel.fromRemoteMessage(
          RemoteMessage message, NotificationMessageType type) =>
      PushMessageModel(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', 'replace') ??
                '',
        title: message.notification!.title ?? 'Noti UPS',
        body: message.notification!.body ?? 'Notificación',
        sendDate: message.sentTime ?? DateTime.now(),
        notificationMessageType: type,
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl,
      );

  factory PushMessageModel.fromLocalNotificationResponse(
    NotificationResponse message,
  ) {
    Map<String, dynamic> dataMap = {};

    // Verifica si el payload no es nulo y no está vacío
    if (message.payload != null && message.payload!.isNotEmpty) {
      try {
        // Intenta convertir el String a un Map
        dataMap = json.decode(message.payload!) as Map<String, dynamic>;
      } catch (e) {
        // Maneja el error si la conversión falla
        print("Error al convertir payload a Map: $e");
        // Opcionalmente, asigna un valor predeterminado o maneja de otra manera
      }
    }

    return PushMessageModel(
      messageId: message.id.toString(),
      title: 'Noti UPS',
      body: 'Notificación',
      sendDate: DateTime.now(),
      notificationMessageType: NotificationMessageType.onOpenApp,
      // data: message.payload != null ? {'route': message.payload} : null,
      data: dataMap,

      imageUrl: null,
    );
  }
}
