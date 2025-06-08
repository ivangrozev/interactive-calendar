import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interactive_calendar/data/repositories/event/event_repository_remote.dart';

class UserProfileViewModel {

  UserProfileViewModel({required EventRepositoryRemote repository}): _repository = repository;

  final EventRepositoryRemote _repository;

   Stream<QuerySnapshot> getAllEvents() {
    return _repository.getEvents();
   }

   Stream<QuerySnapshot> getEventsById(String userId) {
    return _repository.getEventsById(userId);
   }

}