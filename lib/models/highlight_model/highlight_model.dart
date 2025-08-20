class HighlightResponse {
  final bool success;
  final List<HighlightItem> data;
  final Pagination pagination;

  HighlightResponse({
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory HighlightResponse.fromJson(Map<String, dynamic> json) {
    return HighlightResponse(
      success: json['success'],
      data: List<HighlightItem>.from(
          json['data'].map((x) => HighlightItem.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class HighlightItem {
  final int id;
  final bool isActive;
  final int priority;
  final String type;
  final int? subCategoryId;
  final int? miniSubCategoryId;
  final int? listingId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SubCategory? subCategory;
  final MiniSubCategory? miniSubCategory;
  final Listing? listing;

  HighlightItem({
    required this.id,
    required this.isActive,
    required this.priority,
    required this.type,
    this.subCategoryId,
    this.miniSubCategoryId,
    this.listingId,
    required this.createdAt,
    required this.updatedAt,
    this.subCategory,
    this.miniSubCategory,
    this.listing,
  });

  factory HighlightItem.fromJson(Map<String, dynamic> json) {
    return HighlightItem(
      id: json['id'],
      isActive: json['isActive'],
      priority: json['priority'],
      type: json['type'],
      subCategoryId: json['subCategoryId'],
      miniSubCategoryId: json['miniSubCategoryId'],
      listingId: json['listingId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      subCategory: json['subCategory'] == null
          ? null
          : SubCategory.fromJson(json['subCategory']),
      miniSubCategory: json['miniSubCategory'] == null
          ? null
          : MiniSubCategory.fromJson(json['miniSubCategory']),
      listing: json['listing'] == null
          ? null
          : Listing.fromJson(json['listing']),
    );
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
  final dynamic fromName;
  final bool hasForm;
  final bool hasMiniSubCategory;

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
  final String fromName;
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
    required this.fromName,
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
  final List<String> typeOfService;
  final List<String> venueName;
  final bool contractWhatsapp;
  final dynamic fromName;
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
      typeOfService: List<String>.from(json['typeofservice'].map((x) => x.toString())),
      venueName: List<String>.from(json['venueName'].map((x) => x.toString())),
      contractWhatsapp: json['contractWhatsapp'],
      fromName: json['fromName'],
      hasForm: json['hasForm'],
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final bool hasNext;
  final bool hasPrevious;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalCount: json['totalCount'],
      hasNext: json['hasNext'],
      hasPrevious: json['hasPrevious'],
    );
  }
}