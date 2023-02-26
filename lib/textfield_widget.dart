import 'dart:ui';

import 'package:demowalklist/widget_template.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


/// ============================================================
/// Stateful TextField Widget
/// ===========================================================
class appTextField extends StatefulWidget {
  late WidgetConfigNode widgetConfigNode;

  @override
  _appTextFieldState createState() => _appTextFieldState( widgetConfigNode:  widgetConfigNode);

  appTextField({
    required this.widgetConfigNode,
  });
}

class _appTextFieldState extends State<appTextField> {
  late WidgetConfigNode widgetConfigNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      //decoration: InputDecoration( labelText : widgetConfigNode.name + widgetConfigNode.description),
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
      ),
    );
  }

  _appTextFieldState({
    required this.widgetConfigNode,
  });
}