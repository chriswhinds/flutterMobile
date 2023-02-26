import 'package:demowalklist/widget_template.dart';
import 'package:flutter/material.dart';


void main() async {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: const MyHomePage(title: 'Widget List View Page')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  List<Container> uiWidgetList = [];
  bool isLoading = false;

  ///============================
  /// Begin Lazy Load code
  /// ===========================
  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  ///
  /// Load the widgets completely
  Future _loadMore() async {

    setState(() {
      isLoading = true;
    });

    String configDocPath = 'assets/config/ui_template.json';
    MainPaneBuilder mainPaneBuilder = MainPaneBuilder(configDocPath);
    await mainPaneBuilder.init();
    uiWidgetList = mainPaneBuilder.uiWidgetList;

    setState(() {
      isLoading = false;

    });
  }
  ///
  /// ============================
  /// END Lazy load code








  @override
  Widget build(BuildContext context)  {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic Walk View',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dynamic Walk View"),


        ),
        body: Container(
            height: double.infinity,
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: uiWidgetList
            )

        ),
      ),
    );
  }






}




