class ContactWhatsappResponse {
  final bool success;
  final ContactWhatsappData data;

  ContactWhatsappResponse({
    required this.success,
    required this.data,
  });

  factory ContactWhatsappResponse.fromJson(Map<String, dynamic> json) {
    return ContactWhatsappResponse(
      success: json['success'],
      data: ContactWhatsappData.fromJson(json['data']),
    );
  }
}

class ContactWhatsappData {
  final int id;
  final String name;
  final String img;
  final Map<String, dynamic> description;
  final bool hasSpecificCategory;
  final int mainCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;
  final bool hasMiniSubCategory;
  final String? heroSection;
  final MainCategory mainCategory;
  final List<dynamic> specificCategories;
  final List<dynamic> miniSubCategory;
  final AdminWhatsApp adminWhatsApp;

  ContactWhatsappData({
    required this.id,
    required this.name,
    required this.img,
    required this.description,
    required this.hasSpecificCategory,
    required this.mainCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.contractWhatsapp,
    this.fromName,
    required this.hasForm,
    required this.hasMiniSubCategory,
    this.heroSection,
    required this.mainCategory,
    required this.specificCategories,
    required this.miniSubCategory,
    required this.adminWhatsApp,
  });

  factory ContactWhatsappData.fromJson(Map<String, dynamic> json) {
    return ContactWhatsappData(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      description: json['description'] as Map<String, dynamic>,
      hasSpecificCategory: json['hasSpecificCategory'],
      mainCategoryId: json['mainCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      contractWhatsapp: json['contractWhatsapp'],
      fromName: json['fromName'],
      hasForm: json['hasForm'],
      hasMiniSubCategory: json['hasMiniSubCategory'],
      heroSection: json['heroSection'],
      mainCategory: MainCategory.fromJson(json['mainCategory']),
      specificCategories: json['specificCategories'] as List<dynamic>,
      miniSubCategory: json['miniSubCategory'] as List<dynamic>,
      adminWhatsApp: AdminWhatsApp.fromJson(json['adminWhatsApp']),
    );
  }

  Map<String, Map<String, String>> getDescriptionByType(String type) {
    if (description[type] != null) {
      return (description[type] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, value.toString() as Map<String, String>),
      );
    }
    return {};
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
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
      whatsapp: json['whatsapp'],
      whatsappLink: json['whatsappLink'],
      whatsappLinkWithInquiry: json['whatsappLinkWithInquiry'],
      mobileWhatsappLink: json['mobileWhatsappLink'],
      serviceName: json['serviceName'],
      message: json['message'],
    );
  }
}




// class ContactWhatsappResponse {
//   final bool success;
//   final SubCategoryData data;
//
//   ContactWhatsappResponse({
//     required this.success,
//     required this.data,
//   });
//
//   factory ContactWhatsappResponse.fromJson(Map<String, dynamic> json) {
//     return ContactWhatsappResponse(
//       success: json['success'],
//       data: SubCategoryData.fromJson(json['data']),
//     );
//   }
// }
//
// class SubCategoryData {
//   final int id;
//   final String name;
//   final String img;
//   final Description description;
//   final bool hasSpecificCategory;
//   final int mainCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool contractWhatsapp;
//   final dynamic fromName;
//   final bool hasForm;
//   final bool hasMiniSubCategory;
//   final HeroSection heroSection;
//   final MainCategory mainCategory;
//   final List<dynamic> specificCategories;
//   final List<dynamic> miniSubCategory;
//   final AdminWhatsApp adminWhatsApp;
//
//   SubCategoryData({
//     required this.id,
//     required this.name,
//     required this.img,
//     required this.description,
//     required this.hasSpecificCategory,
//     required this.mainCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.contractWhatsapp,
//     required this.fromName,
//     required this.hasForm,
//     required this.hasMiniSubCategory,
//     required this.heroSection,
//     required this.mainCategory,
//     required this.specificCategories,
//     required this.miniSubCategory,
//     required this.adminWhatsApp,
//   });
//
//   factory SubCategoryData.fromJson(Map<String, dynamic> json) {
//     return SubCategoryData(
//       id: json['id'],
//       name: json['name'],
//       img: json['img'],
//       description: Description.fromJson(json['description']),
//       hasSpecificCategory: json['hasSpecificCategory'],
//       mainCategoryId: json['mainCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       contractWhatsapp: json['contractWhatsapp'],
//       fromName: json['fromName'],
//       hasForm: json['hasForm'],
//       hasMiniSubCategory: json['hasMiniSubCategory'],
//       heroSection: HeroSection.fromJson(json['heroSection']),
//       mainCategory: MainCategory.fromJson(json['mainCategory']),
//       specificCategories: List<dynamic>.from(json['specificCategories']),
//       miniSubCategory: List<dynamic>.from(json['miniSubCategory']),
//       adminWhatsApp: AdminWhatsApp.fromJson(json['adminWhatsApp']),
//     );
//   }
// }
//
// class Description {
//   final String content;
//   final List<String> sections;
//
//   Description({
//     required this.content,
//     required this.sections,
//   });
//
//   factory Description.fromJson(Map<String, dynamic> json) {
//     return Description(
//       content: json['content'],
//       sections: List<String>.from(json['sections']),
//     );
//   }
// }
//
// class HeroSection {
//   final String imageUrl;
//
//   HeroSection({
//     required this.imageUrl,
//   });
//
//   factory HeroSection.fromJson(Map<String, dynamic> json) {
//     return HeroSection(
//       imageUrl: json['imageUrl'],
//     );
//   }
// }
//
// class MainCategory {
//   final int id;
//   final String name;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   MainCategory({
//     required this.id,
//     required this.name,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory MainCategory.fromJson(Map<String, dynamic> json) {
//     return MainCategory(
//       id: json['id'],
//       name: json['name'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }
//
// class AdminWhatsApp {
//   final String whatsapp;
//   final String whatsappLink;
//   final String whatsappLinkWithInquiry;
//   final String mobileWhatsappLink;
//   final String serviceName;
//   final String message;
//
//   AdminWhatsApp({
//     required this.whatsapp,
//     required this.whatsappLink,
//     required this.whatsappLinkWithInquiry,
//     required this.mobileWhatsappLink,
//     required this.serviceName,
//     required this.message,
//   });
//
//   factory AdminWhatsApp.fromJson(Map<String, dynamic> json) {
//     return AdminWhatsApp(
//       whatsapp: json['whatsapp'],
//       whatsappLink: json['whatsappLink'],
//       whatsappLinkWithInquiry: json['whatsappLinkWithInquiry'],
//       mobileWhatsappLink: json['mobileWhatsappLink'],
//       serviceName: json['serviceName'],
//       message: json['message'],
//     );
//   }
// }