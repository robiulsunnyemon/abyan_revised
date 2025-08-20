//
// class SubCategoryModel {
//   final bool success;
//   final Data data;
//
//   SubCategoryModel({
//     required this.success,
//     required this.data,
//   });
//
//   factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
//     return SubCategoryModel(
//       success: json['success'],
//       data: Data.fromJson(json['data']),
//     );
//   }
// }
//
// class Data {
//   final List<SubCategory> subCategories;
//   final Pagination pagination;
//
//   Data({
//     required this.subCategories,
//     required this.pagination,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       subCategories: List<SubCategory>.from(
//           json['subCategories'].map((x) => SubCategory.fromJson(x))),
//       pagination: Pagination.fromJson(json['pagination']),
//     );
//   }
// }
//
// class SubCategory {
//   final int id;
//   final String name;
//   final String img;
//   final dynamic description; // Can be null or Description object
//   final bool hasSpecificCategory;
//   final int mainCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool contractWhatsapp;
//   final dynamic fromName; // Can be null or String
//   final bool hasForm;
//   final bool hasMiniSubCategory;
//   final HeroSection? heroSection;
//   final MainCategory mainCategory;
//   final List<SpecificCategory> specificCategories;
//   final List<MiniSubCategory> miniSubCategory;
//
//   SubCategory({
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
//     this.heroSection,
//     required this.mainCategory,
//     required this.specificCategories,
//     required this.miniSubCategory,
//   });
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     return SubCategory(
//       id: json['id'],
//       name: json['name'],
//       img: json['img'],
//       description: json['description'] == null
//           ? null
//           : json['description'] is String
//           ? json['description']
//           : Description.fromJson(json['description']),
//       hasSpecificCategory: json['hasSpecificCategory'],
//       mainCategoryId: json['mainCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       contractWhatsapp: json['contractWhatsapp'],
//       fromName: json['fromName'],
//       hasForm: json['hasForm'],
//       hasMiniSubCategory: json['hasMiniSubCategory'],
//       heroSection: json['heroSection'] == null
//           ? null
//           : HeroSection.fromJson(json['heroSection']),
//       mainCategory: MainCategory.fromJson(json['mainCategory']),
//       specificCategories: List<SpecificCategory>.from(
//           json['specificCategories'].map((x) => SpecificCategory.fromJson(x))),
//       miniSubCategory: List<MiniSubCategory>.from(
//           json['miniSubCategory'].map((x) => MiniSubCategory.fromJson(x))),
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
// class SpecificCategory {
//   final int id;
//   final String name;
//   final int subCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final List<Listing> listings;
//
//   SpecificCategory({
//     required this.id,
//     required this.name,
//     required this.subCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.listings,
//   });
//
//   factory SpecificCategory.fromJson(Map<String, dynamic> json) {
//     return SpecificCategory(
//       id: json['id'],
//       name: json['name'],
//       subCategoryId: json['subCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       listings: List<Listing>.from(
//           json['listings'].map((x) => Listing.fromJson(x))),
//     );
//   }
// }
//
// class Listing {
//   final int id;
//   final String name;
//   final String mainImage;
//   final List<String> subImages;
//   final String? location;
//   final List<dynamic> memberPrivileges;
//   final String? memberPrivilegesDescription;
//   final String? description;
//   final List<String> hours;
//   final int specificCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String? formName;
//   final bool isActive;
//   final List<String> menuImages;
//   final List<String> typeOfService;
//   final List<String> venueName;
//   final bool contractWhatsapp;
//   final dynamic fromName;
//   final bool hasForm;
//
//   Listing({
//     required this.id,
//     required this.name,
//     required this.mainImage,
//     required this.subImages,
//     this.location,
//     required this.memberPrivileges,
//     this.memberPrivilegesDescription,
//     this.description,
//     required this.hours,
//     required this.specificCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     this.formName,
//     required this.isActive,
//     required this.menuImages,
//     required this.typeOfService,
//     required this.venueName,
//     required this.contractWhatsapp,
//     required this.fromName,
//     required this.hasForm,
//   });
//
//   factory Listing.fromJson(Map<String, dynamic> json) {
//     return Listing(
//       id: json['id'],
//       name: json['name'],
//       mainImage: json['main_image'],
//       subImages: List<String>.from(json['sub_images']),
//       location: json['location'],
//       memberPrivileges: List<dynamic>.from(json['member_privileges']),
//       memberPrivilegesDescription: json['member_privileges_description'],
//       description: json['description'],
//       hours: List<String>.from(json['hours'].map((x) => x.toString())),
//       specificCategoryId: json['specificCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       formName: json['formName'],
//       isActive: json['isActive'],
//       menuImages: List<String>.from(json['menuImages']),
//       typeOfService: List<String>.from(json['typeofservice'].map((x) => x.toString())),
//       venueName: List<String>.from(json['venueName'].map((x) => x.toString())),
//       contractWhatsapp: json['contractWhatsapp'],
//       fromName: json['fromName'],
//       hasForm: json['hasForm'],
//     );
//   }
// }
//
// class MiniSubCategory {
//   final int id;
//   final String name;
//   final String img;
//   final bool hasSpecificCategory;
//   final int subCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool contractWhatsapp;
//   final String fromName;
//   final bool hasForm;
//
//   MiniSubCategory({
//     required this.id,
//     required this.name,
//     required this.img,
//     required this.hasSpecificCategory,
//     required this.subCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.contractWhatsapp,
//     required this.fromName,
//     required this.hasForm,
//   });
//
//   factory MiniSubCategory.fromJson(Map<String, dynamic> json) {
//     return MiniSubCategory(
//       id: json['id'],
//       name: json['name'],
//       img: json['img'],
//       hasSpecificCategory: json['hasSpecificCategory'],
//       subCategoryId: json['subCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       contractWhatsapp: json['contractWhatsapp'],
//       fromName: json['fromName'],
//       hasForm: json['hasForm'],
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


class SubCategoryModel {
  final bool success;
  final Data data;

  SubCategoryModel({
    required this.success,
    required this.data,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final List<SubCategory> subCategories;
  final Pagination pagination;

  Data({
    required this.subCategories,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      subCategories: List<SubCategory>.from(
          json['subCategories'].map((x) => SubCategory.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class SubCategory {
  final int id;
  final String name;
  final String img;
  final dynamic description; // Can be null, String or Description object
  final bool hasSpecificCategory;
  final int mainCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool contractWhatsapp;
  final dynamic fromName; // Can be null or String
  final bool hasForm;
  final bool hasMiniSubCategory;
  final HeroSection? heroSection;
  final MainCategory mainCategory;
  final List<SpecificCategory> specificCategories;
  final List<dynamic> miniSubCategory; // Empty array in response

  SubCategory({
    required this.id,
    required this.name,
    required this.img,
    required this.description,
    required this.hasSpecificCategory,
    required this.mainCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.contractWhatsapp,
    required this.fromName,
    required this.hasForm,
    required this.hasMiniSubCategory,
    this.heroSection,
    required this.mainCategory,
    required this.specificCategories,
    required this.miniSubCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      description: json['description'] == null
          ? null
          : json['description'] is String
          ? json['description']
          : Description.fromJson(json['description']),
      hasSpecificCategory: json['hasSpecificCategory'],
      mainCategoryId: json['mainCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      contractWhatsapp: json['contractWhatsapp'],
      fromName: json['fromName'],
      hasForm: json['hasForm'],
      hasMiniSubCategory: json['hasMiniSubCategory'],
      heroSection: json['heroSection'] == null
          ? null
          : HeroSection.fromJson(json['heroSection']),
      mainCategory: MainCategory.fromJson(json['mainCategory']),
      specificCategories: List<SpecificCategory>.from(
          json['specificCategories'].map((x) => SpecificCategory.fromJson(x))),
      miniSubCategory: List<dynamic>.from(json['miniSubCategory']),
    );
  }
}

class Description {
  final String content;
  final List<String> sections;

  Description({
    required this.content,
    required this.sections,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      content: json['content'],
      sections: List<String>.from(json['sections']),
    );
  }
}

class HeroSection {
  final String imageUrl;

  HeroSection({
    required this.imageUrl,
  });

  factory HeroSection.fromJson(Map<String, dynamic> json) {
    return HeroSection(
      imageUrl: json['imageUrl'],
    );
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

class SpecificCategory {
  final int id;
  final String name;
  final int subCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Listing> listings;

  SpecificCategory({
    required this.id,
    required this.name,
    required this.subCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.listings,
  });

  factory SpecificCategory.fromJson(Map<String, dynamic> json) {
    return SpecificCategory(
      id: json['id'],
      name: json['name'],
      subCategoryId: json['subCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      listings: List<Listing>.from(
          json['listings'].map((x) => Listing.fromJson(x))),
    );
  }
}

class Listing {
  final int id;
  final String name;
  final String mainImage;
  final List<String> subImages;
  final String? location;
  final List<dynamic> memberPrivileges;
  final String? memberPrivilegesDescription;
  final String? description;
  final List<String> hours;
  final int specificCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? formName;
  final bool isActive;
  final List<String> menuImages;
  final List<dynamic> typeOfService; // Empty array in response
  final List<dynamic> venueName; // Empty array in response
  final bool contractWhatsapp;
  final dynamic fromName; // Can be null
  final bool hasForm;

  Listing({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.subImages,
    this.location,
    required this.memberPrivileges,
    this.memberPrivilegesDescription,
    this.description,
    required this.hours,
    required this.specificCategoryId,
    required this.createdAt,
    required this.updatedAt,
    this.formName,
    required this.isActive,
    required this.menuImages,
    required this.typeOfService,
    required this.venueName,
    required this.contractWhatsapp,
    required this.fromName,
    required this.hasForm,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'],
      name: json['name'],
      mainImage: json['main_image'],
      subImages: List<String>.from(json['sub_images']),
      location: json['location'],
      memberPrivileges: List<dynamic>.from(json['member_privileges']),
      memberPrivilegesDescription: json['member_privileges_description'],
      description: json['description'],
      hours: List<String>.from(json['hours'].map((x) => x.toString())),
      specificCategoryId: json['specificCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      formName: json['formName'],
      isActive: json['isActive'],
      menuImages: List<String>.from(json['menuImages']),
      typeOfService: List<dynamic>.from(json['typeofservice']),
      venueName: List<dynamic>.from(json['venueName']),
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