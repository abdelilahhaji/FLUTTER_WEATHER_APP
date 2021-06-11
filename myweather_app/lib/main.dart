import 'package:flutter/material.dart';
import 'package:myweather_app/page/home/home.page.dart';
import 'package:myweather_app/page/photos/home.page.dart';
import 'package:myweather_app/page/users/users.page.dart';

void main() {
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      routes: {
        "/": (context) => HomePage(),
        "/users": (context) => UsersPage(),
        "/photos":(context) => PhotosPage()
      },
      initialRoute: "/users",
      home: HomePage(),
    );
  }
}
