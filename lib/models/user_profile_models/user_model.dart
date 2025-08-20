class UserModel {
  final String id;
  final String name;
  final String email;
  final String whatsapp;
  final String profilePic;
  final String role;
  final bool isActive;
  final bool isVerified;
  final bool paid;
  final String package;
  final bool sendPaymentLink;
  final String? fcmToken;
  final String uid;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.whatsapp,
    required this.profilePic,
    required this.role,
    required this.isActive,
    required this.isVerified,
    required this.paid,
    required this.package,
    required this.sendPaymentLink,
    this.fcmToken,
    required this.uid,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      whatsapp: json['whatsapp'],
      profilePic: json['profile_pic'],
      role: json['role'],
      isActive: json['isActive'],
      isVerified: json['isVerified'],
      paid: json['paid'],
      package: json['package'],
      sendPaymentLink: json['send_payment_link'],
      fcmToken: json['fcm_token'],
      uid: json['uid'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'whatsapp': whatsapp,
      'profile_pic': profilePic,
      'role': role,
      'isActive': isActive,
      'isVerified': isVerified,
      'paid': paid,
      'package': package,
      'send_payment_link': sendPaymentLink,
      'fcm_token': fcmToken,
      'uid': uid,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class UserResponse {
  final bool success;
  final UserModel data;

  UserResponse({
    required this.success,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'],
      data: UserModel.fromJson(json['data']),
    );
  }
}