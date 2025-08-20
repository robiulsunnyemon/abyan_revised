// notification_model.dart
class NotificationResponse {
  final bool success;
  final NotificationData data;

  NotificationResponse({
    required this.success,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'] ?? false,
      data: NotificationData.fromJson(json['data']),
    );
  }
}

class NotificationData {
  final List<AppNotification> notifications;
  final Pagination pagination;

  NotificationData({
    required this.notifications,
    required this.pagination,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => AppNotification.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class AppNotification {
  final String id;
  final String userId;
  final String title;
  final String message;
  final bool isRead;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      isRead: json['isRead'] ?? false,
      role: json['role'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int pages;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 0,
    );
  }
}
