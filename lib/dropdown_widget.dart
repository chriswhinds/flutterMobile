import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/**
 *  Stateful DropDownButton Widget
 */
class appDropdownButton extends StatefulWidget {
  List<dynamic> options = [];

  @override
  _appDropdownButtonState createState() => _appDropdownButtonState(options:options);

  appDropdownButton({
    required this.options,
  });
}

class _appDropdownButtonState extends State<appDropdownButton> {

  List<dynamic> options = [];
  String _selectedValue = 'Not Selected';
  List<String> optionsStrings = [];

  @override
  Widget build(BuildContext context) {
    // _selectedValue = options[1];
    return DropdownButton<String>(
        value: _selectedValue,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            print('Selected value -> $newValue ');
            _selectedValue = newValue.toString()!;
          });
        },
        items:  buildItemList()
    );
  }

  _appDropdownButtonState({
    required this.options,
  });

  ///
  /// Build the list of items
  List<DropdownMenuItem<String>> buildItemList(){
    List<DropdownMenuItem<String>> items = [];
    options.forEach((value) {
      print("Adding->" + value);
      items.add(DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ));
    });

    return items;

  }




}