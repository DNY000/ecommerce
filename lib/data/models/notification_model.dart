import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String userId; // ID của người nhận thông báo
  final String title; // Tiêu đề thông báo
  final String body; // Nội dung thông báo
  final String type; // Loại thông báo (ví dụ: 'order', 'chat', 'system')
  final Map<String, dynamic>? data; // Dữ liệu bổ sung
  final bool isRead; // Trạng thái đã đọc
  final DateTime createdAt; // Thời gian tạo

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.data,
    this.isRead = false,
    required this.createdAt,
  });

  // Chuyển từ JSON sang Model
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      data: json['data'],
      isRead: json['isRead'] ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  // Chuyển từ Model sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type,
      'data': data,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
