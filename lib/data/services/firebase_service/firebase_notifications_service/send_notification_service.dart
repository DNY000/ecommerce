import 'dart:convert';

import 'package:app1/data/services/firebase_service/firebase_notifications_service/get_service_key.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SendNotificationService {
  static Future<void> sendNotification(
      {required String? token,
      required String? title,
      bool allUser = false,
      required String? body,
      required Map<String, dynamic>? data}) async {
    String serverKey = await GetServiceKey().getServiceKeyToken();
    const url =
        "https://fcm.googleapis.com/v1/projects/social-media-848c7/messages:send";
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };
    Map<String, dynamic> message = {
      'message': {
        'topic': allUser ? "all" : null,
        'token': allUser ? null : token,
        'notification': {'body': body, 'title': title},
        'data': data,
      }
    };
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(message));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Notification sent successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to send notification');
      }
    }
  }
}
