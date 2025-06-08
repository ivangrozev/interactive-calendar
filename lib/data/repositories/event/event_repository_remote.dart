import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interactive_calendar/data/repositories/event/event_repository.dart';
import 'package:interactive_calendar/data/services/event_service.dart';
import 'package:interactive_calendar/domain/models/event.dart';

class EventRepositoryRemote extends EventRepository {
  EventRepositoryRemote({required EventService service}) : _service = service;

  final EventService _service;

  @override
  Future<void> addEvent(Event event) async {
    _service.addEvent(event);
  }

  @override
  Stream<QuerySnapshot> getEvents() {
    return _service.getEventsStream();
  }

  @override
  Stream<QuerySnapshot> getEventsById(String userId) {
    return _service.getEventsStreamById(userId);
  }
  
  @override
  Future<void> updateEvent(String oldEventId, Event newEvent) {
    return _service.updateEvent(oldEventId, newEvent);
  }

  
}
