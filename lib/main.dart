import 'package:dossier_medical/controllers/userController.dart';
import 'package:dossier_medical/views/authentification/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'router.dart';

void main() async {

  await GetStorage.init();
  await FlutterLogs.initLogs(
    logLevelsEnabled: [
      LogLevel.INFO,
      LogLevel.WARNING,
      LogLevel.ERROR,
      LogLevel.SEVERE
    ],
    timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
    directoryStructure: DirectoryStructure.FOR_DATE,
    logTypesEnabled: ["device", "network", "errors", "all"],
    logFileExtension: LogFileExtension.LOG,
    logsWriteDirectoryName: "MyLogs",
    logsExportDirectoryName: "MyLogs/Exported",
    debugFileOperations: true,
    isDebuggable: true,
  );


  ErrorWidget.builder = (FlutterErrorDetails error) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Erreur"),

      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "L'application s'est écrasée \n${error.exception}",
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
              ),
            ]),
      ),
    );
  };

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserController>(
      create: (_) => UserController(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 // var auth = FirebaseAuth.instance;
  var isLogin = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yela Nga',
      initialRoute: '/',
      home: Authentification(),
      onGenerateRoute: Routers.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.transparent,
      ),
    );
  }
}


