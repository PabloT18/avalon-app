enum NotificationMessageType {
  onOpenApp,
  onSuspendApp,
  onTerminateApp,
}

class PushMessage {
  const PushMessage({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sendDate,
    required this.notificationMessageType,
    this.data,
    this.imageUrl,
  });

  final String messageId;
  final String title;
  final String body;
  final DateTime sendDate;
  final NotificationMessageType notificationMessageType;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  @override
  String toString() {
    return '''
---PushMessage---
id:       $messageId
title:    $title
body:     $body
sendDate: $sendDate
type:     $notificationMessageType
data:     $data
imageUrl: $imageUrl
''';
  }

  bool get hasRoute =>
      data != null && data!['route'] != null && data!['route'] != '';

  String? get routeValue => hasRoute ? data!['route'] : null;

  bool get hasDataId =>
      data != null && data!['dataId'] != null && data!['dataId'] != '';

  bool get hasDataName =>
      data != null && data!['dataName'] != null && data!['dataName'] != '';

  String? get dataIdValue => hasDataId ? data!['dataId'] : null;

  String? get dataNameValue => hasDataName ? data!['dataName'] : null;
}
