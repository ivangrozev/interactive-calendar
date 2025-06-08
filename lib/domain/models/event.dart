class Event {
  Event(this.id, this.description, this.color,
      {required this.title,
      required this.startTime,
      required this.endTime,
      required this.createdBy,
      required this.createdAt});

  final String? id;
  final String title;
  final String? description;
  DateTime startTime;
  DateTime endTime;
  String createdBy;
  int? color;
  DateTime createdAt;
}
