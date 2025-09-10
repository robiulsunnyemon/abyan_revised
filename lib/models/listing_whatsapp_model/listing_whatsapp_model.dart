class ListingWhatsappModel {
  final bool success;
  final Data? data;

  ListingWhatsappModel({required this.success, this.data});

  factory ListingWhatsappModel.fromJson(Map<String, dynamic> json) {
    return ListingWhatsappModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final int id;
  final String name;
  final String mainImage;
  final String? location;
  final bool isActive;
  final AdminWhatsApp? adminWhatsApp;
  final SpecificCategory? specificCategory;

  Data({
    required this.id,
    required this.name,
    required this.mainImage,
    this.location,
    required this.isActive,
    this.adminWhatsApp,
    this.specificCategory,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'] ?? '',
      mainImage: json['main_image'] ?? '',
      location: json['location'],
      isActive: json['isActive'] ?? false,
      adminWhatsApp: json['adminWhatsApp'] != null
          ? AdminWhatsApp.fromJson(json['adminWhatsApp'])
          : null,
      specificCategory: json['specificCategory'] != null
          ? SpecificCategory.fromJson(json['specificCategory'])
          : null,
    );
  }
}

class AdminWhatsApp {
  final String whatsapp;
  final String whatsappLink;
  final String whatsappLinkWithInquiry;
  final String mobileWhatsappLink;
  final String serviceName;
  final String message;

  AdminWhatsApp({
    required this.whatsapp,
    required this.whatsappLink,
    required this.whatsappLinkWithInquiry,
    required this.mobileWhatsappLink,
    required this.serviceName,
    required this.message,
  });

  factory AdminWhatsApp.fromJson(Map<String, dynamic> json) {
    return AdminWhatsApp(
      whatsapp: json['whatsapp'] ?? '',
      whatsappLink: json['whatsappLink'] ?? '',
      whatsappLinkWithInquiry: json['whatsappLinkWithInquiry'] ?? '',
      mobileWhatsappLink: json['mobileWhatsappLink'] ?? '',
      serviceName: json['serviceName'] ?? '',
      message: json['message'] ?? '',
    );
  }
}

class SpecificCategory {
  final int id;
  final String name;

  SpecificCategory({required this.id, required this.name});

  factory SpecificCategory.fromJson(Map<String, dynamic> json) {
    return SpecificCategory(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}
