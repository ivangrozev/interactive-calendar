import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_calendar/domain/models/event.dart';
import 'package:interactive_calendar/event/viewmodels/event_viewmodel.dart';
import 'package:interactive_calendar/routing/Routes.dart';

class AddEventForm extends StatefulWidget {
  const AddEventForm(this.event,
      {super.key, required this.viewModel, required this.currentUserId});

  final EventViewModel viewModel;
  final String currentUserId;
  final Map<String, dynamic>? event;

  @override
  State<AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  Color _currentColor = Colors.green;

  final _delimiterHeight = const SizedBox(height: 20);
  final _delimiterWidth = const SizedBox(width: 50);

  void setNewCurrentColor(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  DateTime parseTimeStamp(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value);
    return date;
  }

  void _pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Pick your color'),
            content: Column(
              children: [
                buildColorPicker(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'SELECT',
                      style: TextStyle(fontSize: 20.0),
                    )),
              ],
            ),
          ));

  Widget buildColorPicker() => ColorPicker(
      pickerColor: _currentColor,
      onColorChanged: (color) => setState(() => _currentColor = color));

  @override
  Widget build(BuildContext context) {
    bool isEventForUpdate = widget.event != null;
    if (isEventForUpdate) {
      setState(() {
        _currentColor = Color(widget.event!['colorARGB32'] as int);
      });
      Timestamp start = widget.event!['startTime'] as Timestamp;
      Timestamp end = widget.event!['endTime'] as Timestamp;
      _title.text = widget.event!['title'];
      _description.text = widget.event!['description'];
      _startDate = parseTimeStamp(start.millisecondsSinceEpoch);
      _endDate = parseTimeStamp(end.millisecondsSinceEpoch);
    }
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: _title,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          _delimiterHeight,
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            controller: _description,
          ),
          _delimiterHeight,
          _delimiterHeight,
          Row(
            children: [
              const Text(
                'Pick start date:',
                style: TextStyle(fontSize: 15),
              ),
              _delimiterWidth,
              IconButton(
                icon: const Icon(
                  Icons.calendar_month_rounded,
                  size: 30,
                ),
                onPressed: () {
                  widget.viewModel.selectDate(context).then((pickedDate) {
                    setState(() {
                      _startDate = pickedDate;
                    });
                  });
                },
              ),
              widget.viewModel.checkSelectedDate(_startDate),
            ],
          ),
          widget.viewModel.divider,
          _delimiterHeight,
          Row(
            children: [
              const Text(
                'Pick end date:',
                style: TextStyle(fontSize: 16),
              ),
              _delimiterWidth,
              IconButton(
                icon: const Icon(
                  Icons.calendar_month,
                  size: 30,
                ),
                onPressed: () {
                  widget.viewModel.selectDate(context).then((pickedDate) {
                    setState(() {
                      _endDate = pickedDate;
                    });
                  });
                },
              ),
              widget.viewModel.checkSelectedDate(_endDate),
            ],
          ),
          widget.viewModel.divider,
          _delimiterHeight,
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _pickColor(context);
                  },
                  child: const Text('Pick label color')),
              _delimiterWidth,
              Container(
                width: 25,
                height: 25,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: _currentColor),
              )
            ],
          ),
          _delimiterHeight,
          widget.viewModel.divider,
          _delimiterHeight,
          ElevatedButton(
              onPressed: () {
                var event = Event(
                    null, _description.text, _currentColor.toARGB32(),
                    title: _title.text,
                    createdAt: DateTime.now(),
                    startTime: _startDate!,
                    endTime: _endDate!,
                    createdBy: widget.currentUserId);
                if (isEventForUpdate) {
                  widget.viewModel.updateEvent(widget.event!['id'], event);
                  context.go(Routes.profile);
                } else {
                  widget.viewModel.addEvent(event, context);
                  context.go(Routes.home);
                }
              },
              child: Text(isEventForUpdate ? 'Update' : 'Create'))
        ],
      ),
    );
  }
}
