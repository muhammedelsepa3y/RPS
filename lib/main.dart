import 'package:flutter/material.dart';

import 'modules/home/home.dart';
import 'modules/welcome_page/welcome_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
home: Welcome_Page(),
    );
  }

}