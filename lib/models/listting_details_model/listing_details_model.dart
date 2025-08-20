// class ListingDetailResponse {
//   final bool success;
//   final ListingDetailData data;
//
//   ListingDetailResponse({
//     required this.success,
//     required this.data,
//   });
//
//   factory ListingDetailResponse.fromJson(Map<String, dynamic> json) {
//     return ListingDetailResponse(
//       success: json['success'],
//       data: ListingDetailData.fromJson(json['data']),
//     );
//   }
// }
//
// class ListingDetailData {
//   final int id;
//   final String name;
//   final String mainImage;
//   final List<String> subImages;
//   final String location;
//   final List<dynamic> memberPrivileges;
//   final String memberPrivilegesDescription;
//   final String description;
//   final List<String> hours;
//   final int specificCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String formName;
//   final bool isActive;
//   final List<String> menuImages;
//   final List<String> typeOfService;
//   final List<String> venueName;
//   final bool contractWhatsapp;
//   final String? fromName;
//   final bool hasForm;
//   final SpecificCategory specificCategory;
//   final List<Booking> bookings;
//
//   ListingDetailData({
//     required this.id,
//     required this.name,
//     required this.mainImage,
//     required this.subImages,
//     required this.location,
//     required this.memberPrivileges,
//     required this.memberPrivilegesDescription,
//     required this.description,
//     required this.hours,
//     required this.specificCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.formName,
//     required this.isActive,
//     required this.menuImages,
//     required this.typeOfService,
//     required this.venueName,
//     required this.contractWhatsapp,
//     this.fromName,
//     required this.hasForm,
//     required this.specificCategory,
//     required this.bookings,
//   });
//
//   factory ListingDetailData.fromJson(Map<String, dynamic> json) {
//     return ListingDetailData(
//       id: json['id'],
//       name: json['name'],
//       mainImage: json['main_image'],
//       subImages: List<String>.from(json['sub_images']),
//       location: json['location'],
//       memberPrivileges: json['member_privileges'],
//       memberPrivilegesDescription: json['member_privileges_description'],
//       description: json['description'],
//       hours: List<String>.from(json['hours']),
//       specificCategoryId: json['specificCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       formName: json['formName'],
//       isActive: json['isActive'],
//       menuImages: List<String>.from(json['menuImages']),
//       typeOfService: List<String>.from(json['typeofservice']),
//       venueName: List<String>.from(json['venueName']),
//       contractWhatsapp: json['contractWhatsapp'] ?? false,
//       fromName: json['fromName'],
//       hasForm: json['hasForm'] ?? false,
//       specificCategory: SpecificCategory.fromJson(json['specificCategory']),
//       bookings: List<Booking>.from(
//           json['bookings'].map((x) => Booking.fromJson(x))),
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
//   final SubCategory subCategory;
//
//   SpecificCategory({
//     required this.id,
//     required this.name,
//     required this.subCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.subCategory,
//   });
//
//   factory SpecificCategory.fromJson(Map<String, dynamic> json) {
//     return SpecificCategory(
//       id: json['id'],
//       name: json['name'],
//       subCategoryId: json['subCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       subCategory: SubCategory.fromJson(json['subCategory']),
//     );
//   }
// }
//
// class SubCategory {
//   final int id;
//   final String name;
//   final String img;
//   final dynamic description;
//   final bool hasSpecificCategory;
//   final int mainCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool contractWhatsapp;
//   final String? fromName;
//   final bool hasForm;
//   final bool hasMiniSubCategory;
//   final MainCategory mainCategory;
//
//   SubCategory({
//     required this.id,
//     required this.name,
//     required this.img,
//     this.description,
//     required this.hasSpecificCategory,
//     required this.mainCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.contractWhatsapp,
//     this.fromName,
//     required this.hasForm,
//     required this.hasMiniSubCategory,
//     required this.mainCategory,
//   });
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     return SubCategory(
//       id: json['id'],
//       name: json['name'],
//       img: json['img'],
//       description: json['description'],
//       hasSpecificCategory: json['hasSpecificCategory'],
//       mainCategoryId: json['mainCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       contractWhatsapp: json['contractWhatsapp'] ?? false,
//       fromName: json['fromName'],
//       hasForm: json['hasForm'] ?? false,
//       hasMiniSubCategory: json['hasMiniSubCategory'] ?? false,
//       mainCategory: MainCategory.fromJson(json['mainCategory']),
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
// class Booking {
//   final int id;
//   final String userId;
//   final int listingId;
//   final DateTime bookingDate;
//   final String bookingTime;
//   final String status;
//   final String name;
//   final String email;
//   final String whatsapp;
//   final String venueName;
//   final dynamic typeOfService;
//   final int numberOfGuestAdult;
//   final int numberOfGuestChild;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final User user;
//
//   Booking({
//     required this.id,
//     required this.userId,
//     required this.listingId,
//     required this.bookingDate,
//     required this.bookingTime,
//     required this.status,
//     required this.name,
//     required this.email,
//     required this.whatsapp,
//     required this.venueName,
//     this.typeOfService,
//     required this.numberOfGuestAdult,
//     required this.numberOfGuestChild,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.user,
//   });
//
//   factory Booking.fromJson(Map<String, dynamic> json) {
//     return Booking(
//       id: json['id'],
//       userId: json['userId'],
//       listingId: json['listingId'],
//       bookingDate: DateTime.parse(json['bookingDate']),
//       bookingTime: json['bookingTime'],
//       status: json['status'],
//       name: json['name'],
//       email: json['email'],
//       whatsapp: json['whatsapp'],
//       venueName: json['venueName'],
//       typeOfService: json['typeofservice'],
//       numberOfGuestAdult: json['numberofguest_adult'],
//       numberOfGuestChild: json['numberofguest_child'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       user: User.fromJson(json['user']),
//     );
//   }
// }
//
// class User {
//   final String id;
//   final String name;
//   final String email;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//     );
//   }
// }
//
//


class ListingDetailResponse {
  final bool success;
  final ListingDetailData data;

  ListingDetailResponse({
    required this.success,
    required this.data,
  });

  factory ListingDetailResponse.fromJson(Map<String, dynamic> json) {
    return ListingDetailResponse(
      success: json['success'],
      data: ListingDetailData.fromJson(json['data']),
    );
  }
}

// class ListingDetailData {
//   final int id;
//   final String name;
//   final String mainImage;
//   final List<String> subImages;
//   final String location;
//   final List<dynamic> memberPrivileges;
//   final String memberPrivilegesDescription;
//   final String description;
//   final List<String> hours;
//   final int specificCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool isActive;
//   final List<String> menuImages;
//   final List<String> typeOfService;
//   final List<String> venueName;
//   final bool contractWhatsapp;
//   final String? fromName;
//   final bool hasForm;
//   final SpecificCategory specificCategory;
//   final List<Booking> bookings;
//
//   ListingDetailData({
//     required this.id,
//     required this.name,
//     required this.mainImage,
//     required this.subImages,
//     required this.location,
//     required this.memberPrivileges,
//     required this.memberPrivilegesDescription,
//     required this.description,
//     required this.hours,
//     required this.specificCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isActive,
//     required this.menuImages,
//     required this.typeOfService,
//     required this.venueName,
//     required this.contractWhatsapp,
//     this.fromName,
//     required this.hasForm,
//     required this.specificCategory,
//     required this.bookings,
//   });
//
//   factory ListingDetailData.fromJson(Map<String, dynamic> json) {
//     return ListingDetailData(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       mainImage: json['main_image'] ??'',
//       subImages: List<String>.from(json['sub_images']),
//       location: json['location'],
//       memberPrivileges: json['member_privileges'],
//       memberPrivilegesDescription: json['member_privileges_description'],
//       description: json['description'],
//       hours: List<String>.from(json['hours']),
//       specificCategoryId: json['specificCategoryId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       isActive: json['isActive'],
//       menuImages: List<String>.from(json['menuImages']),
//       typeOfService: List<String>.from(json['typeofservice']),
//       venueName: List<String>.from(json['venueName']),
//       contractWhatsapp: json['contractWhatsapp'] ?? false,
//       fromName: json['fromName'],
//       hasForm: json['hasForm'] ?? false,
//       specificCategory: SpecificCategory.fromJson(json['specificCategory']),
//       bookings: List<Booking>.from(
//           json['bookings'].map((x) => Booking.fromJson(x))),
//     );
//   }
// }

class ListingDetailData {
  final int id;
  final String name;
  final String mainImage;
  final List<String> subImages;
  final String? location; // Nullable
  final List<dynamic> memberPrivileges;
  final String? memberPrivilegesDescription; // Nullable
  final String? description; // Nullable
  final List<String> hours;
  final int specificCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final List<String> menuImages;
  final List<String> typeOfService;
  final List<String> venueName;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;
  final SpecificCategory specificCategory;
  final List<Booking> bookings;

  ListingDetailData({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.subImages,
    this.location, // Nullable
    required this.memberPrivileges,
    this.memberPrivilegesDescription, // Nullable
    this.description, // Nullable
    required this.hours,
    required this.specificCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.menuImages,
    required this.typeOfService,
    required this.venueName,
    required this.contractWhatsapp,
    this.fromName,
    required this.hasForm,
    required this.specificCategory,
    required this.bookings,
  });

  factory ListingDetailData.fromJson(Map<String, dynamic> json) {
    return ListingDetailData(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      mainImage: json['main_image'] as String? ?? '',
      subImages: List<String>.from(json['sub_images'] ?? []),
      location: json['location'] as String?,
      memberPrivileges: List<dynamic>.from(json['member_privileges'] ?? []),
      memberPrivilegesDescription: json['member_privileges_description'] as String?,
      description: json['description'] as String?,
      hours: List<String>.from(json['hours'] ?? []),
      specificCategoryId: json['specificCategoryId'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String? ?? '1970-01-01'),
      updatedAt: DateTime.parse(json['updatedAt'] as String? ?? '1970-01-01'),
      isActive: json['isActive'] as bool? ?? false,
      menuImages: List<String>.from(json['menuImages'] ?? []),
      typeOfService: List<String>.from(json['typeofservice'] ?? []),
      venueName: List<String>.from(json['venueName'] ?? []),
      contractWhatsapp: json['contractWhatsapp'] as bool? ?? false,
      fromName: json['fromName'] as String?,
      hasForm: json['hasForm'] as bool? ?? false,
      specificCategory: SpecificCategory.fromJson(json['specificCategory'] ?? {}),
      bookings: List<Booking>.from(
          (json['bookings'] as List? ?? []).map((x) => Booking.fromJson(x as Map<String, dynamic>? ?? {}))),
    );
  }
}

class SpecificCategory {
  final int id;
  final String name;
  final int subCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SubCategory subCategory;

  SpecificCategory({
    required this.id,
    required this.name,
    required this.subCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategory,
  });

  factory SpecificCategory.fromJson(Map<String, dynamic> json) {
    return SpecificCategory(
      id: json['id'],
      name: json['name'],
      subCategoryId: json['subCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      subCategory: SubCategory.fromJson(json['subCategory']),
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
      id: json['id'],
      name: json['name'],
      img: json['img'],
      description: json['description'],
      hasSpecificCategory: json['hasSpecificCategory'],
      mainCategoryId: json['mainCategoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      contractWhatsapp: json['contractWhatsapp'] ?? false,
      fromName: json['fromName'],
      hasForm: json['hasForm'] ?? false,
      hasMiniSubCategory: json['hasMiniSubCategory'] ?? false,
      mainCategory: MainCategory.fromJson(json['mainCategory']),
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

class Booking {
  final int id;
  final String userId;
  final int listingId;
  final DateTime bookingDate;
  final String bookingTime;
  final String status;
  final String name;
  final String email;
  final String whatsapp;
  final String venueName;
  final dynamic typeOfService;
  final int numberOfGuestAdult;
  final int numberOfGuestChild;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  Booking({
    required this.id,
    required this.userId,
    required this.listingId,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    required this.name,
    required this.email,
    required this.whatsapp,
    required this.venueName,
    this.typeOfService,
    required this.numberOfGuestAdult,
    required this.numberOfGuestChild,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['userId'],
      listingId: json['listingId'],
      bookingDate: DateTime.parse(json['bookingDate']),
      bookingTime: json['bookingTime'],
      status: json['status'],
      name: json['name'],
      email: json['email'],
      whatsapp: json['whatsapp'],
      venueName: json['venueName'],
      typeOfService: json['typeofservice'],
      numberOfGuestAdult: json['numberofguest_adult'],
      numberOfGuestChild: json['numberofguest_child'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}