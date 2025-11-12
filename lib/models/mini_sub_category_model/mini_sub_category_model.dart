// lib/models/mini_sub_category_model.dart
class MiniSubCategory {
  final int id;
  final String name;
  final String img;
  final bool hasSpecificCategory;
  final int subCategoryId;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;
  final DateTime createdAt;
  final DateTime updatedAt;

  MiniSubCategory({
    required this.id,
    required this.name,
    required this.img,
    required this.hasSpecificCategory,
    required this.subCategoryId,
    required this.contractWhatsapp,
    this.fromName,
    required this.hasForm,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MiniSubCategory.fromJson(Map<String, dynamic> json) {
    return MiniSubCategory(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      hasSpecificCategory: json['hasSpecificCategory'],
      subCategoryId: json['subCategoryId'],
      contractWhatsapp: json['contractWhatsapp'],
      fromName: json['fromName'],
      hasForm: json['hasForm'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'hasSpecificCategory': hasSpecificCategory,
      'subCategoryId': subCategoryId,
      'contractWhatsapp': contractWhatsapp,
      'fromName': fromName,
      'hasForm': hasForm,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
class SubCategoryFullModel {
  final int id;
  final String name;
  final String img;
  final Map<String, dynamic>? description; // ✅ updated
  final bool hasSpecificCategory;
  final int mainCategoryId;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;
  final bool hasMiniSubCategory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MiniSubCategory> miniSubCategory;

  SubCategoryFullModel({
    required this.id,
    required this.name,
    required this.img,
    this.description,
    required this.hasSpecificCategory,
    required this.mainCategoryId,
    required this.contractWhatsapp,
    this.fromName,
    required this.hasForm,
    required this.hasMiniSubCategory,
    required this.createdAt,
    required this.updatedAt,
    required this.miniSubCategory,
  });

  factory SubCategoryFullModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryFullModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      description: json['description'] != null
          ? Map<String, dynamic>.from(json['description'])
          : null,
      hasSpecificCategory: json['hasSpecificCategory'],
      mainCategoryId: json['mainCategoryId'],
      contractWhatsapp: json['contractWhatsapp'],
      fromName: json['fromName'],
      hasForm: json['hasForm'],
      hasMiniSubCategory: json['hasMiniSubCategory'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      miniSubCategory: (json['miniSubCategory'] as List<dynamic>?)
          ?.map((e) => MiniSubCategory.fromJson(e))
          .toList() ??
          [],
    );
  }
}

