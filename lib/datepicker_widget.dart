import 'package:demowalklist/widget_template.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/// ===================================================================================
/// New Date Picker
/// ===================================================================================
class appDatePickerWidget extends StatefulWidget {
  const appDatePickerWidget({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<appDatePickerWidget> createState() => _appDatePickerWidgeState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _appDatePickerWidgeState extends State<appDatePickerWidget>  with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;
  final _dateController = TextEditingController();

  final RestorableDateTime _selectedDate =  RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        _dateController.text =  '${_selectedDate.value.month}/${_selectedDate.value.day}/${_selectedDate.value.year}';

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.date_range_sharp),
          tooltip: 'Select a Date',
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _dateController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),

      ],
    );




  }
}