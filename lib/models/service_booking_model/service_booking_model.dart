class ServiceBookingModel {
  final bool success;
  final ServiceBookingData data;

  ServiceBookingModel({
    required this.success,
    required this.data,
  });

  factory ServiceBookingModel.fromJson(Map<String, dynamic> json) {
    return ServiceBookingModel(
      success: json['success'],
      data: ServiceBookingData.fromJson(json['data']),
    );
  }
}

class ServiceBookingData {
  final List<Booking> all;
  final List<Booking> pending;
  final List<Booking> confirmed;
  final List<Booking> complete;
  final List<Booking> cancelled;
  final Pagination pagination;

  ServiceBookingData({
    required this.all,
    required this.pending,
    required this.confirmed,
    required this.complete,
    required this.cancelled,
    required this.pagination,
  });

  factory ServiceBookingData.fromJson(Map<String, dynamic> json) {
    return ServiceBookingData(
      all: List<Booking>.from(json['all'].map((x) => Booking.fromJson(x))),
      pending: List<Booking>.from(json['pending'].map((x) => Booking.fromJson(x))),
      confirmed: List<Booking>.from(json['confirmed'].map((x) => Booking.fromJson(x))),
      complete: List<Booking>.from(json['complete'].map((x) => Booking.fromJson(x))),
      cancelled: List<Booking>.from(json['cancelled'].map((x) => Booking.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Booking {
  final int id;
  final String type;
  final String userId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BookingInfo? bookingInfo;
  final SubCategory? subCategory;
  final MiniSubCategory? miniSubCategory;
  final Listing? listing;
  final MainCategory? mainCategory;
  final User user;

  Booking({
    required this.id,
    required this.type,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.bookingInfo,
    this.subCategory,
    this.miniSubCategory,
    this.listing,
    this.mainCategory,
    required this.user,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      type: json['type'],
      userId: json['userId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      bookingInfo: json['bookingInfo'] != null ? BookingInfo.fromJson(json['bookingInfo']) : null,
      subCategory: json['subCategory'] != null ? SubCategory.fromJson(json['subCategory']) : null,
      miniSubCategory: json['miniSubCategory'] != null ? MiniSubCategory.fromJson(json['miniSubCategory']) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing']) : null,
      mainCategory: json['mainCategory'] != null ? MainCategory.fromJson(json['mainCategory']) : null,
      user: User.fromJson(json['user']),
    );
  }
}

class BookingInfo {
  final Guests guests;
  final String contact;
  final Location location;
  final String checkInDate;
  final String nameOfHotel;
  final String checkOutDate;
  final int? miniSubCategoryId;
  final int? subCategoryId;
  final String typeOfAccommodation;

  BookingInfo({
    required this.guests,
    required this.contact,
    required this.location,
    required this.checkInDate,
    required this.nameOfHotel,
    required this.checkOutDate,
    this.miniSubCategoryId,
    this.subCategoryId,
    required this.typeOfAccommodation,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      guests: Guests.fromJson(json['guests']),
      contact: json['contact'],
      location: Location.fromJson(json['location']),
      checkInDate: json['checkInDate'],
      nameOfHotel: json['nameOfHotel'],
      checkOutDate: json['checkOutDate'],
      miniSubCategoryId: json['miniSubCategoryId'],
      subCategoryId: json['subCategoryId'],
      typeOfAccommodation: json['typeOfAccommodation'],
    );
  }
}

class Guests {
  final int adults;
  final int children;

  Guests({
    required this.adults,
    required this.children,
  });

  factory Guests.fromJson(Map<String, dynamic> json) {
    return Guests(
      adults: json['adults'],
      children: json['children'],
    );
  }
}

class Location {
  final String? from;
  final String? to;

  Location({
    this.from,
    this.to,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      from: json['from'],
      to: json['to'],
    );
  }
}

class SubCategory {
  final int id;
  final String name;
  final String img;
  final String? description;
  final bool hasSpecificCategory;
  final int mainCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool contractWhatsapp;
  final String? fromName;
  final bool hasForm;
  final bool hasMiniSubCategory;
  final MainCategory? mainCategory;

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
    this.mainCategory,
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
      mainCategory: json['mainCategory'] != null ? MainCategory.fromJson(json['mainCategory']) : null,
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
  final String location;
  final String description;
  final bool isActive;
  final List<String> menuImages;
  final List<dynamic> memberPrivileges;
  final String memberPrivilegesDescription;
  final List<String> hours;
  final List<dynamic> typeofservice;
  final List<dynamic> venueName;
  final SpecificCategory specificCategory;
  final SubCategory subCategory;
  final MainCategory mainCategory;

  Listing({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.subImages,
    required this.location,
    required this.description,
    required this.isActive,
    required this.menuImages,
    required this.memberPrivileges,
    required this.memberPrivilegesDescription,
    required this.hours,
    required this.typeofservice,
    required this.venueName,
    required this.specificCategory,
    required this.subCategory,
    required this.mainCategory,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'],
      name: json['name'],
      mainImage: json['main_image'],
      subImages: List<String>.from(json['sub_images'].map((x) => x)),
      location: json['location'],
      description: json['description'],
      isActive: json['isActive'],
      menuImages: List<String>.from(json['menuImages'].map((x) => x)),
      memberPrivileges: List<dynamic>.from(json['member_privileges'].map((x) => x)),
      memberPrivilegesDescription: json['member_privileges_description'],
      hours: List<String>.from(json['hours'].map((x) => x)),
      typeofservice: List<dynamic>.from(json['typeofservice'].map((x) => x)),
      venueName: List<dynamic>.from(json['venueName'].map((x) => x)),
      specificCategory: SpecificCategory.fromJson(json['specificCategory']),
      subCategory: SubCategory.fromJson(json['subCategory']),
      mainCategory: MainCategory.fromJson(json['mainCategory']),
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

class Pagination {
  final int page;
  final int limit;
  final Counts counts;
  final Pages pages;

  Pagination({
    required this.page,
    required this.limit,
    required this.counts,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      counts: Counts.fromJson(json['counts']),
      pages: Pages.fromJson(json['pages']),
    );
  }
}

class Counts {
  final int all;
  final int pending;
  final int confirmed;
  final int complete;
  final int cancelled;

  Counts({
    required this.all,
    required this.pending,
    required this.confirmed,
    required this.complete,
    required this.cancelled,
  });

  factory Counts.fromJson(Map<String, dynamic> json) {
    return Counts(
      all: json['all'],
      pending: json['pending'],
      confirmed: json['confirmed'],
      complete: json['complete'],
      cancelled: json['cancelled'],
    );
  }
}

class Pages {
  final int all;
  final int pending;
  final int confirmed;
  final int complete;
  final int cancelled;

  Pages({
    required this.all,
    required this.pending,
    required this.confirmed,
    required this.complete,
    required this.cancelled,
  });

  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      all: json['all'],
      pending: json['pending'],
      confirmed: json['confirmed'],
      complete: json['complete'],
      cancelled: json['cancelled'],
    );
  }
}