import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id; // ID của người nhận thông báo
  final String title; // Tiêu đề thông báo
  final String body; // Nội dung thông báo
  final String type; // Loại thông báo (ví dụ: 'order', 'chat', 'system')
  final Map<String, dynamic>? data; // Dữ liệu bổ sung
  final bool isRead; // Trạng thái đã đọc
  final DateTime createdAt; // Thời gian tạo

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.data,
    this.isRead = false,
    required this.createdAt,
  });
  static NotificationModel empty() => NotificationModel(
        id: '',
        title: '',
        body: '',
        type: '',
        data: null,
        isRead: false,
        createdAt: DateTime.now(),
      );
  // Chuyển từ JSON sang Model
  // factory NotificationModel.fromJson(Map<String, dynamic> json) {
  //   return NotificationModel(
  //     id: json['id'] ?? '',
  //     title: json['title'] ?? '',
  //     body: json['body'] ?? '',
  //     type: json['type'] ?? '',
  //     data: json['data'],
  //     isRead: json['isRead'] ?? false,
  //     createdAt: (json['createdAt'] as Timestamp).toDate(),
  //   );
  // }

  // Chuyển từ Model sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'data': data,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory NotificationModel.fromSnapshot(snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (data.isEmpty) return empty();
    return NotificationModel(
      id: snapshot.id,
      title: data['title'],
      body: data['body'],
      type: data['type'],
      data: data['data'],
      isRead: data['isRead'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    String? type,
    Map<String, dynamic>? data,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      data: data ?? this.data,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
