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
/// Stateful Multi-line TextField Widget
/// ===========================================================
class appMultiLineTextField extends StatefulWidget {
  late WidgetConfigNode widgetConfigNode;

  @override
  _appMultiLineTextFieldState createState() => _appMultiLineTextFieldState( widgetConfigNode:  widgetConfigNode);

  appMultiLineTextField({
    required this.widgetConfigNode,
  });
}

class _appMultiLineTextFieldState extends State<appMultiLineTextField> {
  late WidgetConfigNode widgetConfigNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: 25,
      //expands: true,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
      ),
    );
  }

  _appMultiLineTextFieldState({
    required this.widgetConfigNode,
  });
}