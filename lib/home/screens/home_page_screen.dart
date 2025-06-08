import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_calendar/home/viewmodels/home_viewmodel.dart';
import 'package:interactive_calendar/home/widgets/calendar.dart';
import 'package:interactive_calendar/routing/Routes.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 21, 21, 78),
          title: const Text(
            'Interactive Calendar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.edit_calendar_outlined),
            onPressed: () => context.go(
                  Routes.addEvent,
                  extra: widget.viewModel.getCurrentUserId(),
                )),
        body: const Center(
          child: Column(
            children: [
              Calendar(),
            ],
          ),
        ),
      ),
    );
  }
}
