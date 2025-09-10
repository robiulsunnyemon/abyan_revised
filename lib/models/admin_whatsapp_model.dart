// models/whatsapp_response.dart
class WhatsAppResponse {
  final bool success;
  final WhatsAppData data;

  WhatsAppResponse({
    required this.success,
    required this.data,
  });

  factory WhatsAppResponse.fromJson(Map<String, dynamic> json) {
    return WhatsAppResponse(
      success: json['success'] ?? false,
      data: WhatsAppData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class WhatsAppData {
  final bool success;
  final String whatsapp;
  final String whatsappLink;

  WhatsAppData({
    required this.success,
    required this.whatsapp,
    required this.whatsappLink,
  });

  factory WhatsAppData.fromJson(Map<String, dynamic> json) {
    return WhatsAppData(
      success: json['success'] ?? false,
      whatsapp: json['whatsapp'] ?? '',
      whatsappLink: json['whatsappLink'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'whatsapp': whatsapp,
      'whatsappLink': whatsappLink,
    };
  }
}