import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppbarCustoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Image.asset(
        'assets/logowhite.png',
        fit: BoxFit.contain,
        height: 50,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [
                0.1,
                0.80,
              ],
              colors: [
                HexColor('00ff00'),
                HexColor('05d0ae'),
              ]),
          border: Border.all(
            color: Colors.transparent,
            width: 0,
          ),
        ),
      ),
      elevation: 0.0,
    );
  }
}
