import 'dart:async';

import 'package:flutter/material.dart';

import '../login_page/login_page.dart';

class Welcome_Page extends StatelessWidget {
  const Welcome_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>LoginPage() )));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/rps.png",height: 350,width: 350,),
          ],
        ),
      ),
    );
  }
}
