// class CategoryResponse {
//   final bool success;
//   final CategoryData data;
//   final Pagination pagination;
//
//   CategoryResponse({
//     required this.success,
//     required this.data,
//     required this.pagination,
//   });
//
//   factory CategoryResponse.fromJson(Map<String, dynamic> json) {
//     return CategoryResponse(
//       success: json['success'],
//       data: CategoryData.fromJson(json['data']),
//       pagination: Pagination.fromJson(json['data']['pagination']),
//     );
//   }
// }
//
// class CategoryData {
//   final List<MainCategory> mainCategories;
//
//   CategoryData({required this.mainCategories});
//
//   factory CategoryData.fromJson(Map<String, dynamic> json) {
//     var list = json['mainCategories'] as List;
//     List<MainCategory> categories = list
//         .map((category) => MainCategory.fromJson(category))
//         .toList();
//     return CategoryData(mainCategories: categories);
//   }
// }
//
// class MainCategory {
//   final int id;
//   final String name;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final List<SubCategory> subCategories;
//
//   MainCategory({
//     required this.id,
//     required this.name,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.subCategories,
//   });
//
//   factory MainCategory.fromJson(Map<String, dynamic> json) {
//     var subList = json['subCategories'] as List? ?? [];
//     List<SubCategory> subCategories = subList
//         .map((sub) => SubCategory.fromJson(sub))
//         .toList();
//
//     return MainCategory(
//       id: json['id'],
//       name: json['name'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       subCategories: subCategories,
//     );
//   }
// }
//
// class SubCategory {
//   final int id;
//   final String name;
//   final String img;
//   final bool hasSpecificCategory;
//   final int mainCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool contractWhatsapp;
//   final String? fromName;
//   final bool hasForm;
//   final List<SpecificCategory> specificCategories;
//
//   SubCategory({
//     required this.id,
//     required this.name,
//     required this.img,
//     required this.hasSpecificCategory,
//     required this.mainCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.contractWhatsapp,
//     this.fromName,
//     required this.hasForm,
//     required this.specificCategories,
//   });
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     var specificList = json['specificCategories'] as List? ?? [];
//     List<SpecificCategory> specificCategories = specificList
//         .map((specific) => SpecificCategory.fromJson(specific))
//         .toList();
//
//     return SubCategory(
//       id: json['id'],
//       name: json['name'],
//       img: json['img'],
//       hasSpecificCategory: json['hasSpecificCategory'],
//       mainCategoryId: json['mainCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       contractWhatsapp: json['contractWhatsapp'],
//       fromName: json['fromName'],
//       hasForm: json['hasForm'],
//       specificCategories: specificCategories,
//     );
//   }
// }
//
// class SpecificCategory {
//   final int id;
//   final String name;
//   final int subCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   SpecificCategory({
//     required this.id,
//     required this.name,
//     required this.subCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory SpecificCategory.fromJson(Map<String, dynamic> json) {
//     return SpecificCategory(
//       id: json['id'],
//       name: json['name'],
//       subCategoryId: json['subCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }
//
// class Pagination {
//   final int page;
//   final int limit;
//   final int total;
//   final int pages;
//
//   Pagination({
//     required this.page,
//     required this.limit,
//     required this.total,
//     required this.pages,
//   });
//
//   factory Pagination.fromJson(Map<String, dynamic> json) {
//     return Pagination(
//       page: json['page'],
//       limit: json['limit'],
//       total: json['total'],
//       pages: json['pages'],
//     );
//   }
// }



class CategoryResponse {
  final bool success;
  final CategoryData data;
  final Pagination pagination;

  CategoryResponse({
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'],
      data: CategoryData.fromJson(json['data']),
      pagination: Pagination.fromJson(json['data']['pagination']),
    );
  }
}

class CategoryData {
  final List<MainCategory> mainCategories;
  final Pagination pagination;

  CategoryData({
    required this.mainCategories,
    required this.pagination,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      mainCategories: List<MainCategory>.from(
          json['mainCategories'].map((x) => MainCategory.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class MainCategory {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SubCategory> subCategories;

  MainCategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategories,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      subCategories: List<SubCategory>.from(
          json['subCategories'].map((x) => SubCategory.fromJson(x))),
    );
  }
}

class SubCategory {
  final int id;
  final String name;
  final String img;
  final dynamic description; // Can be null, String or Map
  final bool hasSpecificCategory;
  final int mainCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;
  final bool hasMiniSubCategory;
  final List<SpecificCategory> specificCategories;
  final List<MiniSubCategory> miniSubCategory;

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
    required this.specificCategories,
    required this.miniSubCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      description: json['description'],
      hasSpecificCategory: json['hasSpecificCategory'],
      mainCategoryId: json['mainCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      contractWhatsapp: json['contractWhatsapp'],
      fromName: json['fromName'],
      hasForm: json['hasForm'],
      hasMiniSubCategory: json['hasMiniSubCategory'],
      specificCategories: List<SpecificCategory>.from(
          json['specificCategories'].map((x) => SpecificCategory.fromJson(x))),
      miniSubCategory: List<MiniSubCategory>.from(
          json['miniSubCategory'].map((x) => MiniSubCategory.fromJson(x))),
    );
  }

  // Helper method to get description content
  String? get descriptionContent {
    if (description == null) return null;
    if (description is String) return description as String;
    if (description is Map) return description['content'] as String?;
    return null;
  }

  // Helper method to get description sections
  List<String>? get descriptionSections {
    if (description == null || description is! Map) return null;
    return (description['sections'] as List?)?.cast<String>();
  }
}

class SpecificCategory {
  final int id;
  final String name;
  final int subCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  SpecificCategory({
    required this.id,
    required this.name,
    required this.subCategoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SpecificCategory.fromJson(Map<String, dynamic> json) {
    return SpecificCategory(
      id: json['id'],
      name: json['name'],
      subCategoryId: json['subCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class MiniSubCategory {
  final int id;
  final String name;
  final String img;
  final bool hasSpecificCategory;
  final int subCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;

  MiniSubCategory({
    required this.id,
    required this.name,
    required this.img,
    required this.hasSpecificCategory,
    required this.subCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.contractWhatsapp,
    this.fromName,
    required this.hasForm,
  });

  factory MiniSubCategory.fromJson(Map<String, dynamic> json) {
    return MiniSubCategory(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      hasSpecificCategory: json['hasSpecificCategory'],
      subCategoryId: json['subCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      contractWhatsapp: json['contractWhatsapp'],
      fromName: json['fromName'],
      hasForm: json['hasForm'],
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
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      pages: json['pages'],
    );
  }
}