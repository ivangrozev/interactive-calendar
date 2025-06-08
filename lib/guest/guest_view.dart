import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_calendar/data/services/event_service.dart';
import 'package:interactive_calendar/routing/Routes.dart';
import 'package:interactive_calendar/ui/events_list_view_builder.dart';

class GuestView extends StatelessWidget {
  GuestView({super.key});

  final EventsListViewBuilder eventsListViewBuilder = EventsListViewBuilder();
  final EventService _eventService = EventService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.go(Routes.home),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'Guest view',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 21, 21, 78),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: eventsListViewBuilder
              .getEventsListViewBuilder(_eventService.getEventsStream()),
        ),
      ),
    );
  }
}
