import 'package:demowalklist/widget_template.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


///=============================================================
/// Stateful NumericField Widget
/// ============================================================
class appNumericField extends StatefulWidget {
  late WidgetConfigNode widgetConfigNode;

  @override
  _appNumericFieldState createState() => _appNumericFieldState( widgetConfigNode:  widgetConfigNode);

  appNumericField({
    required this.widgetConfigNode,
  });
}

class _appNumericFieldState extends State<appNumericField> {
  late WidgetConfigNode widgetConfigNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      //decoration: InputDecoration( labelText : widgetConfigNode.name + widgetConfigNode.description),
      style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          height: 2.0
      ),
    );
  }

  _appNumericFieldState({
    required this.widgetConfigNode,
  });
}