import 'dart:ui';

import 'package:demowalklist/textfield_widget.dart';
import 'package:demowalklist/timepicker_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'datepicker_widget.dart';
import 'dropdown_widget.dart';
import 'multilinetextfield_widget.dart';
import 'numericfield_widget.dart';



enum WidgetDataType {

  Numeric("numeric"),
  Text("text"),
  Date("date"),
  Time("time"),
  DateTime("datetime"),
  SingleChoice("singlechoice");
  const WidgetDataType(this.value);
  final String value;



}

/*
Place holder class to temp hold widget defintion from the config
 */
class WidgetConfigNode {


  String name = "";
  String description ="";
  String type = "";
  String inputtype = '';
  List<dynamic> options = [];


  WidgetConfigNode(this.name,
                   this.description,
                   this.type,
                   this.options,
                   this.inputtype);


}

///=======================
///   UI Configuaration Loader
/// =====================
class UIConfigLoader {

  var config = "";
  List<Map<String, dynamic>> uiconfig = [ {'dummy':'dummy'}];

  /**
   * Initalize
   */
  initFromFileSystem() {

    uiconfig = parseJsonConfigFromAssets( config);


  }
  ///
  /// HTTP Init
  ///
  void loadFromRemote() async {
    print("Fetching template remote - start");
    var url = 'https://walktemplates.s3.amazonaws.com/ui_template.json';
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
        var tempJson = json.decode(response.body);
        uiconfig = (tempJson as List).map((e) => e as Map<String, dynamic>).toList();
        print("Fetching template remote - complete");
     } else {
        print('Request failed with status: ${response.statusCode}');
    }



  }



  ///
  /// HTTP Init
  ///
  void loadFromRemoteX()  {
    print("Fetching template remote - start");
    var url = 'https://walktemplates.s3.amazonaws.com/ui_template.json';
    Uri uri = Uri.parse(url);
    var response = http.get(uri).then((response) {
    if (response.statusCode == 200) {
        var tempJson = json.decode(response.body);
        uiconfig = (tempJson as List).map((e) => e as Map<String, dynamic>).toList();
        print("Fetching template remote - complete");
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    });


  }

  /**
   * Load UI Config JSON and Parsde into List of Maps to Strings
   */
  //Future<List<Map<String, dynamic>>> parseJsonConfigFromAssets( BuildContext context,   String assetsPath) async {
  List<Map<String, dynamic>> parseJsonConfigFromAssets( String assetsPath)  {
    print('--- Read and Parse json from: $assetsPath');
    File file = File(assetsPath);
    String contents = file.readAsStringSync();
    var tempJson = jsonDecode(contents);
    List<Map<String,dynamic>> retval = (tempJson as List).map((e) => e as Map<String, dynamic>).toList();
    //List<Map<String,dynamic>> retval = jsonDecode(data );

    print('--- Parse json completed: ');
    return retval;



  }

  UIConfigLoader(this.config);

}



/*
  Builds the entire entry screen from the configureation JSON structure
 */
class MainPaneBuilder  {

  var config = "";
  List<Map<String, dynamic>> uiconfig = [ {'dummy':'dummy'}];

  // Main Consytructor
  MainPaneBuilder(this.config);

  /**
   * Load UI Config JSON and Parsde into List of Maps to Strings
   */
  //Future<List<Map<String, dynamic>>> parseJsonConfigFromAssets( BuildContext context,   String assetsPath) async {
  Future<List<Map<String, dynamic>>> parseJsonConfigFromAssets( String assetsPath) async {
    print('--- Read and Parse json from: $assetsPath');

    String data = await rootBundle.loadString(assetsPath);
    print('--- read json completed: ');
    var tempJson = jsonDecode(data);
    List<Map<String,dynamic>> retval = (tempJson as List).map((e) => e as Map<String, dynamic>).toList();
    //List<Map<String,dynamic>> retval = jsonDecode(data );

    print('--- Parse json completed: ');
    return retval;

  }



  /*
  This initalizer looks wrong , but got to compile si leave for now
   */
  List<Container> uiWidgetList = [];

  /**
   * INitialize the widgets
   */
  //Future<String> init(BuildContext context) async {
  Future<String> init() async {
    //uiWidgetList.length = 0;
    print("init() Starting");

    //Load confile Json into a map ( would come form a server API call
   // LoadJsonConfig(context);
    //uiconfig = fetchJsonConfig(configFilePath);

    await parseJsonConfigFromAssets( config)
        .then( (value) => {
      uiconfig = value
    });



    // Create a list of widgets configs
    uiconfig.forEach(( value) {
          Map<String, dynamic> reqNodes = value;

          var name = reqNodes['name'] ?? '';
          var description = reqNodes['description'] ?? '';
          var type = value ['data_type'] ?? '';
          var options = reqNodes["options"] ?? List<dynamic>.empty();
          var inputtype = value ['input_type'] ?? '';

          WidgetConfigNode widgetConfigNode = WidgetConfigNode( name,
                                                                description,
                                                                type,
                                                                options,
                                                                inputtype);


          switch (  widgetConfigNode.type) {
            case "numeric":

                uiWidgetList.add(
                    Container(
                      //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        height: 100,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: InputDecorator(
                               decoration: InputDecoration(
                                   border: OutlineInputBorder(),
                                  labelText: widgetConfigNode.name + ' ' + widgetConfigNode.description
                               ),
                             child: appNumericField(widgetConfigNode: widgetConfigNode)
                        )

                      )
                );
                print("Added Numeric Widget");
                break;
            case "text": {

                        switch (  widgetConfigNode.inputtype) {
                          case "keypad":
                            uiWidgetList.add(
                                  Container(
                                      //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(15),
                                        height: 100,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child:InputDecorator(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: widgetConfigNode.name + ' ' + widgetConfigNode.description
                                            ),
                                            child:  appTextField(widgetConfigNode: widgetConfigNode)
                                        )

                                    )

                                );
                            print("Added Text Widget");
                            break;
                          case "single_choice":
                            uiWidgetList.add(
                                 Container(
                                      //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(15),
                                        height: 90,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: InputDecorator(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: widgetConfigNode.name + ' ' + widgetConfigNode.description
                                            ),
                                            child:  appDropdownButton(options: widgetConfigNode.options)
                                        )

                                    )

                            );
                            print("Added Single Select Widget");
                            break;
                        }

              }
              break;
            case "date":
              uiWidgetList.add(
                      Container(
                        //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(15),
                          height: 100,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InputDecorator(
                                  decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: widgetConfigNode.name + ' ' + widgetConfigNode.description
                              ),
                              //child:  appDatePickerField(widgetConfigNode: widgetConfigNode)
                              child: appDatePickerWidget(restorationId: 'main')
                          )
                      )


              );

              print("Added Date Picker Widget");
              break;
            case "time":
                uiWidgetList.add(
                                Container(
                                  //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(15),
                                    height: 90,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                      child: InputDecorator(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: widgetConfigNode.name + ' ' + widgetConfigNode.description
                                          ),
                                          //child:  appTimePickerField(widgetConfigNode: widgetConfigNode)
                                          child: appTimePickerWidget()
                                      )




                               )


                          );

              print("Added Time Picker Widget");
              break;
            case "text-multi-line":
              uiWidgetList.add(
                  Container(
                    //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      height: 200,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InputDecorator(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: widgetConfigNode.name + ' ' + widgetConfigNode.description
                          ),
                          //child:  appTimePickerField(widgetConfigNode: widgetConfigNode)
                          child: appMultiLineTextField( widgetConfigNode: widgetConfigNode)
                      )


                  )

              );

              print("Added Date Time Picker Widget");
              break;

          };
        });
    print("init() Ended");
    String endNotification = 'Init completed';
    return endNotification;
  }



}














