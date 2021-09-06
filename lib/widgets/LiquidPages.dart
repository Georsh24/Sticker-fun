import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final estiloTexto = TextStyle(fontSize: 20.0, color: Colors.white);

final liquidPages = [
  Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
          0.1,
          0.60,
        ],
            colors: [
          HexColor('00ff00'),
          HexColor('05d0ae'),
        ])),
    child: Stack(
      children: [
        Positioned(
          child: ClipPath(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logowhite.png',
                  width: 500,
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
  Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
          0.1,
          0.60,
        ],
            colors: [
          HexColor('99d98c'),
          HexColor('4361ee'),
        ])),
    child: Stack(
      children: [
        Positioned(
          child: ClipPath(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logowhite.png',
                  width: 500,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                    ])),
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    'hola',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                onPressed: () {}),
          ),
        )
      ],
    ),
  ),
];
