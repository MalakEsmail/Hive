import 'package:flutter/material.dart';
import 'package:hive_with_flutter/constants.dart';
import 'package:hive_with_flutter/models/contact.dart';
import 'package:hive_with_flutter/screens/contact_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Hive.openBox(Constants.contactBoxName,
            compactionStrategy: (int total, int deleted) {
          return deleted > 20;
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return ContactScreen();
          } else {
            return Scaffold(
              body: Text('no thing to show '),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.box(Constants.contactBoxName).compact();
    Hive.close();
    super.dispose();
  }
}
