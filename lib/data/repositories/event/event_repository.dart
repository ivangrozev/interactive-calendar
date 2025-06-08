import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interactive_calendar/domain/models/event.dart';

abstract class EventRepository {
  Future<void> addEvent(Event event);
  Stream<QuerySnapshot> getEvents();
  Stream<QuerySnapshot> getEventsById(String userId);
  Future<void> updateEvent(String oldEventId, Event newEvent);
}