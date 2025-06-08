import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interactive_calendar/domain/models/event.dart';
import 'package:uuid/uuid.dart';

class EventService {
  final CollectionReference events =
      FirebaseFirestore.instance.collection('events');
  final uuid = const Uuid();

  Future<void> addEvent(Event event) {
    return events.add({
      'id': event.id ?? uuid.v1(),
      'title': event.title,
      'description': event.description,
      'startTime': event.startTime,
      'endTime': event.endTime,
      'colorARGB32': event.color,
      'createdBy': event.createdBy,
      'createdAt': event.createdAt
    });
  }

  Stream<QuerySnapshot> getEventsStream() {
    final eventsStream =
        events.orderBy('createdAt', descending: true).snapshots();
    return eventsStream;
  }

  Stream<QuerySnapshot> getEventsStreamById(String userId) {
    final eventsStream = events
        .orderBy('createdAt', descending: true)
        .where('createdBy', isEqualTo: userId)
        .snapshots();
    return eventsStream;
  }

  Future<void> updateEvent(String eventId, Event newEvent) {
    return events.doc(eventId).update({
      'title': newEvent.title,
      'description': newEvent.description,
      'startTime': newEvent.startTime,
      'endTime': newEvent.endTime,
      'labelColorHex': newEvent.color,
      'createdBy': newEvent.createdBy,
      'createdAt': newEvent.createdAt
    });
  }

  Future<void> deleteId(String eventId) {
    return events.doc(eventId).delete();
  }
}
