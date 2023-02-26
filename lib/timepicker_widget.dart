import 'package:demowalklist/widget_template.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//====================================================================
///  Time picker Widget
///=====================================================================
class appTimePickerWidget extends StatefulWidget {
  @override
  _appTimePickerWidgetState createState() => _appTimePickerWidgetState();
}

class _appTimePickerWidgetState extends State<appTimePickerWidget> {
  TimeOfDay _time = TimeOfDay.now();
  final _timeController = TextEditingController();

  void _selectTime() async {
    print('Time Picker Button Selected');
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        _timeController.text = '${_time.hour}:${_time.minute}';
      });
    }
  }

  Widget build(BuildContext context) {


    return Row(
      children: [
        ElevatedButton(
          onPressed: _selectTime,
          child: Text('SELECT TIME'),
        ),
        /*IconButton(
          icon: const Icon(Icons.timelapse_outlined),
          tooltip: 'Select a Date',
          onPressed: _selectTime,
        ),*/
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _timeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),

      ],
    );

  }



}