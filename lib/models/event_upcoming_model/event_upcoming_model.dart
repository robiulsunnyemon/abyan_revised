class EventUpcomingModel {
  final bool success;
  final EventData data;

  EventUpcomingModel({
    required this.success,
    required this.data,
  });

  factory EventUpcomingModel.fromJson(Map<String, dynamic> json) {
    return EventUpcomingModel(
      success: json['success'],
      data: EventData.fromJson(json['data']),
    );
  }
}

class EventData {
  final List<Event> events;
  final Pagination pagination;

  EventData({
    required this.events,
    required this.pagination,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    var eventsList = json['events'] as List;
    List<Event> events = eventsList.map((e) => Event.fromJson(e)).toList();

    return EventData(
      events: events,
      pagination: Pagination.fromJson(json['pagination']),
    );
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
  final int bookingCount;

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
    required this.bookingCount,
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
      bookingCount: json['_count']['bookings'],
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