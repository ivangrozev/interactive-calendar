import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_calendar/data/services/auth_service.dart';
import 'package:interactive_calendar/event/viewmodels/event_viewmodel.dart';
import 'package:interactive_calendar/event/widgets/add_event_form.dart';
import 'package:interactive_calendar/routing/Routes.dart';

class AddEventScreen extends StatelessWidget {
  
  AddEventScreen(this.event, {super.key, required this.viewmodel});

  final EventViewModel viewmodel;
  late  final Map<String, dynamic>? event;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    String currentUserId = _authService.getCurrentUserId();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 21, 78),
        leading: IconButton(
            onPressed: () => context.go(Routes.home), icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: const Text(
          'Add event',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AddEventForm(event, viewModel: viewmodel, currentUserId: currentUserId,),
            )
            ),
      ),
    );
  }
}
