import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interactive_calendar/data/repositories/auth/auth_repository_remote.dart';
import 'package:interactive_calendar/ui/events_list_view_builder.dart';
import 'package:interactive_calendar/user/viewmodels/user_profile_viewmodel.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen(
      {super.key, required this.viewmodel, required AuthRepositoryRemote auth})
      : _auth = auth;

  final UserProfileViewModel viewmodel;
  final AuthRepositoryRemote _auth;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String userName = widget._auth.getCurrentUserName();
    String email = widget._auth.getCurrentUseEmail();
    String userId = widget._auth.getCurrentUserId();
    Stream<QuerySnapshot> events = widget.viewmodel.getEventsById(userId);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 21, 21, 78),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $userName',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  email,
                  style: const TextStyle(fontSize: 13.0, color: Colors.white),
                )
              ],
            ),
            actionsPadding: const EdgeInsets.only(right: 20.0),
            actions: [
              Row(
                children: [
                  TextButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            Color.fromARGB(255, 255, 255, 255))),
                    onPressed: () {
                      Provider.of<AuthRepositoryRemote>(context, listen: false)
                          .logout();
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(Icons.logout),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: EventsListViewBuilder().getEventsListViewBuilder(events)),
    );
  }
}
