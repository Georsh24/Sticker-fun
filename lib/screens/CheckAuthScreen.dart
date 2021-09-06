import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/screens/HomeScreen.dart';
import 'package:flutter_stickers_internet/screens/SplashScreen.dart';
import 'package:flutter_stickers_internet/services/Services.dart';

import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return Text('Espere');

          if (snapshot.data == '') {
            Future.microtask(() => {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SplashScreen(),
                          transitionDuration: Duration(seconds: 0)))
                });
          } else {
            Future.microtask(() => {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => HomeScreen(),
                          transitionDuration: Duration(seconds: 0)))
                });
          }

          return Container();
        },
      )),
    );
  }
}
