

class SubcategoryDetailResponse {
  final bool success;
  final SubcategoryDetailData data;
  final Pagination pagination;

  SubcategoryDetailResponse({
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory SubcategoryDetailResponse.fromJson(Map<String, dynamic> json) {
    return SubcategoryDetailResponse(
      success: json['success'] ?? false,
      data: SubcategoryDetailData.fromJson(json['data'] ?? {}),
      pagination: Pagination.fromJson(json['data']?['pagination'] ?? {}),
    );
  }
}

class SubcategoryDetailData {
  final SubCategory subCategory;
  final List<SpecificCategoryWithListings> specificCategories;

  SubcategoryDetailData({
    required this.subCategory,
    required this.specificCategories,
  });

  factory SubcategoryDetailData.fromJson(Map<String, dynamic> json) {
    return SubcategoryDetailData(
      subCategory: SubCategory.fromJson(json['subCategory'] ?? {}),
      specificCategories: List<SpecificCategoryWithListings>.from(
          (json['specificCategories'] ?? []).map((specific) =>
              SpecificCategoryWithListings.fromJson(specific))),
    );
  }
}

class SubCategory {
  final int id;
  final String name;
  final String img;
  final bool hasSpecificCategory;
  final int mainCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final MainCategory? mainCategory;
  final String? heroSectionImg;

  SubCategory({
    required this.id,
    required this.name,
    required this.img,
    required this.hasSpecificCategory,
    required this.mainCategoryId,
    required this.createdAt,
    required this.updatedAt,
    this.mainCategory,
    this.heroSectionImg,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      hasSpecificCategory: json['hasSpecificCategory'] ?? false,
      mainCategoryId: json['mainCategoryId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
      mainCategory: json['mainCategory'] != null
          ? MainCategory.fromJson(json['mainCategory'])
          : null,
      heroSectionImg: json['herosection_img'],
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
    );
  }
}

class SpecificCategoryWithListings {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Listing> listings;

  SpecificCategoryWithListings({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.listings,
  });

  factory SpecificCategoryWithListings.fromJson(Map<String, dynamic> json) {
    return SpecificCategoryWithListings(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
      listings: List<Listing>.from(
          (json['listings'] ?? []).map((listing) => Listing.fromJson(listing))),
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
  final bool hasForm;
  final bool contractWhatsapp;
  final String? formName;
  final bool isActive;
  final List<String> menuImages;
  final List<String> typeOfService;
  final List<String> venueName;

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
    this.hasForm = false,
    this.contractWhatsapp = false,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      mainImage: json['main_image'] ?? '',
      subImages: List<String>.from(json['sub_images'] ?? []),
      location: json['location'],
      memberPrivileges: List<dynamic>.from(json['member_privileges'] ?? []),
      memberPrivilegesDescription: json['member_privileges_description'],
      description: json['description'],
      hours: _parseHours(json['hours'] ?? []),
      specificCategoryId: json['specificCategoryId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
      formName: json['formName'],
      isActive: json['isActive'] ?? false,
      menuImages: List<String>.from(json['menuImages'] ?? []),
      typeOfService: _parseStringList(json['typeofservice'] ?? []),
      venueName: _parseStringList(json['venueName'] ?? []),
      hasForm: json['hasForm'] ?? false,
      contractWhatsapp: json['contractWhatsapp'] ?? false,
    );
  }

  static List<String> _parseHours(List<dynamic> hours) {
    return hours.map((hour) => hour?.toString() ?? '').toList();
  }

  static List<String> _parseStringList(List<dynamic> list) {
    return list.map((item) => item?.toString() ?? '').toList();
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
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 0,
    );
  }
}