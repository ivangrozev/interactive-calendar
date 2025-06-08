import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_calendar/data/services/auth_service.dart';
import 'package:interactive_calendar/data/services/event_service.dart';
import 'package:interactive_calendar/routing/Routes.dart';

class EventsListViewBuilder {
  
  final EventService _eventService = EventService();
  final AuthService _authService = AuthService();

  getEventsListViewBuilder(Stream<QuerySnapshot> events) {
    return StreamBuilder<QuerySnapshot>(
      stream: events,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            )),
          );
        }

        if (!snapshot.hasData) {
          return const ListTile(
            title: Text('No events to show!'),
          );
        }
        List events = snapshot.data!.docs;
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = events[index];
            String eventId = document.id;
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String eventTitle = data['title'];
            String description = data['description'];
            final int color = data['colorARGB32'] as int;
            Timestamp startDate = data['startTime'];
            Timestamp endDate = data['endTime'];
            String fromDate =
                'from: ${startDate.toDate().day}.${startDate.toDate().month}.${startDate.toDate().year}';
            String toDate =
                'to: ${endDate.toDate().day}.${endDate.toDate().month}.${endDate.toDate().year}';

            return Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              margin: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text('$fromDate,$toDate'),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(
                            size: 40.0,
                            color: Color(color),
                            Icons.circle,
                          ),
                          title: Text(eventTitle),
                          subtitle: Text(description),
                        ),
                         
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (_authService.isUserLoggedIn()) TextButton(
                              child: const Text('EDIT'),
                              onPressed: () {
                                context.go(Routes.editEvent, extra: data);
                              },
                            ),
                            const SizedBox(width: 8),
                            if (_authService.isUserLoggedIn()) TextButton(
                              child: const Text('DELETE'),
                              onPressed: () {
                                _eventService.deleteId(eventId);
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
