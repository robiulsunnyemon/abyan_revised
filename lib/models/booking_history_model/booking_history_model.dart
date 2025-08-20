

class BookingModel {
  final bool success;
  final BookingData data;

  BookingModel({
    required this.success,
    required this.data,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      success: json['success'],
      data: BookingData.fromJson(json['data']),
    );
  }
}

class BookingData {
  final List<Booking> bookings;
  final Pagination pagination;

  BookingData({
    required this.bookings,
    required this.pagination,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    var bookingsList = json['bookings'] as List;
    List<Booking> bookings = bookingsList.map((e) => Booking.fromJson(e)).toList();

    return BookingData(
      bookings: bookings,
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Booking {
  final int id;
  final String userId;
  final int eventId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Event event;

  Booking({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.event,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['userId'],
      eventId: json['eventId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      event: Event.fromJson(json['event']),
    );
  }

  String get formattedCreatedAt {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} ${createdAt.hour}:${createdAt.minute}';
  }
}

class Event {
  final int id;
  final String title;
  final String eventImg;
  final DateTime date;
  final String time;
  final String description;
  final int maxPerson;
  final String location;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.eventImg,
    required this.date,
    required this.time,
    required this.description,
    required this.maxPerson,
    required this.location,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      eventImg: json['event_img'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      description: json['description'],
      maxPerson: json['max_person'],
      location: json['location'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  String get formattedTime {
    // Assuming time is in format "HH.mm"
    final timeParts = time.split('.');
    if (timeParts.length == 2) {
      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = timeParts[1];
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : hour;
      return '$displayHour:$minute $period';
    }
    return time;
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