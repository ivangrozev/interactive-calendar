import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interactive_calendar/data/repositories/event/event_repository_remote.dart';
import 'package:interactive_calendar/data/services/ui_service_local.dart';
import 'package:interactive_calendar/domain/models/event.dart';

class EventViewModel {
  final divider = const Divider(
    color: Colors.grey,
    height: 1.0,
  );

  EventViewModel(
      {required EventRepositoryRemote repository, required UiService uiService})
      : _repository = repository,
        _uiService = uiService;

  final EventRepositoryRemote _repository;
  final UiService _uiService;

  Stream<QuerySnapshot> getEvents() {
    return _repository.getEvents();
  }

  Stream<QuerySnapshot> getEventsById(String userId) {
    return _repository.getEventsById(userId);
  }

  void addEvent(Event event, BuildContext context) {
    try {
      _repository.addEvent(event);
      _uiService.successSnackBar('Event is added successfuly!', context);
    } catch (e) {
      _uiService.errorSnackBar('Something bad happened!', context);
    }
  }

  void updateEvent(String oldEventId, Event newEvent) {
    _repository.updateEvent(oldEventId, newEvent);
  }

  DateTime now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year, DateTime.december, 31),
    );
    return pickedDate;
  }

  Text checkSelectedDate(DateTime? selectedDate) {
    return Text(
        selectedDate != null
            ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
            : 'No date selected',
        style: const TextStyle(color: Color.fromARGB(255, 1, 47, 255)));
  }
}
