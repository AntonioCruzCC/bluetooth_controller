import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './controller_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluetooth Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ControllerPage(),
    );
  }
}
