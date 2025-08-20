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