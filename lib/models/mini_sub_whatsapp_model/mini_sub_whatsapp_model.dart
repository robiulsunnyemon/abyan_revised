// service_model.dart

class ServiceResponse {
  final bool success;
  final ServiceData data;

  ServiceResponse({required this.success, required this.data});

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      success: json['success'] ?? false,
      data: ServiceData.fromJson(json['data'] ?? {}),
    );
  }
}

class ServiceData {
  final int id;
  final String name;
  final String img;
  final dynamic description;
  final bool hasSpecificCategory;
  final int? subCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;
  final SubCategory? subCategory;
  final AdminWhatsApp? adminWhatsApp;

  ServiceData({
    required this.id,
    required this.name,
    required this.img,
    this.description,
    required this.hasSpecificCategory,
    this.subCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.contractWhatsapp,
    this.fromName,
    required this.hasForm,
    this.subCategory,
    this.adminWhatsApp,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      description: json['description'],
      hasSpecificCategory: json['hasSpecificCategory'] ?? false,
      subCategoryId: json['subCategoryId'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      contractWhatsapp: json['contractWhatsapp'] ?? false,
      fromName: json['fromName'],
      hasForm: json['hasForm'] ?? false,
      subCategory: json['subCategory'] != null
          ? SubCategory.fromJson(json['subCategory'])
          : null,
      adminWhatsApp: json['adminWhatsApp'] != null
          ? AdminWhatsApp.fromJson(json['adminWhatsApp'])
          : null,
    );
  }

  /// Helper for description
  String? getDescriptionContent() {
    if (description is Map<String, dynamic>) return description['content'];
    if (description is String) return description;
    return null;
  }

  List<String> getDescriptionSections() {
    if (description is Map<String, dynamic>) return List<String>.from(description['sections'] ?? []);
    return [];
  }
}

class SubCategory {
  final int id;
  final String name;
  final String img;
  final dynamic description;
  final bool hasSpecificCategory;
  final int mainCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;
  final bool hasMiniSubCategory;
  final MainCategory mainCategory;

  SubCategory({
    required this.id,
    required this.name,
    required this.img,
    this.description,
    required this.hasSpecificCategory,
    required this.mainCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.contractWhatsapp,
    this.fromName,
    required this.hasForm,
    required this.hasMiniSubCategory,
    required this.mainCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      description: json['description'],
      hasSpecificCategory: json['hasSpecificCategory'] ?? false,
      mainCategoryId: json['mainCategoryId'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      contractWhatsapp: json['contractWhatsapp'] ?? false,
      fromName: json['fromName'],
      hasForm: json['hasForm'] ?? false,
      hasMiniSubCategory: json['hasMiniSubCategory'] ?? false,
      mainCategory: MainCategory.fromJson(json['mainCategory'] ?? {}),
    );
  }

  String? getDescriptionContent() {
    if (description is Map<String, dynamic>) return description['content'];
    if (description is String) return description;
    return null;
  }

  List<String> getDescriptionSections() {
    if (description is Map<String, dynamic>) return List<String>.from(description['sections'] ?? []);
    return [];
  }
}

class MainCategory {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  MainCategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
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
