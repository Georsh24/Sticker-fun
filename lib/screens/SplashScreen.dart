import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stickers_internet/screens/LoginScreen.dart';
import 'package:flutter_stickers_internet/widgets/LiquidPages.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LiquidSwipe(
//         pages: liquidPages,
//         fullTransitionValue: 500,
//         enableLoop: false,
//         slideIconWidget: Icon(Icons.arrow_back_ios),
//         positionSlideIcon: 0.5,
//         waveType: WaveType.liquidReveal,
//         onPageChangeCallback: (page) => pageChangeCallback(page),
//         currentUpdateTypeCallback: ( updateType ) => updateTypeCallback( updateType ),
//       )
//     );
//   }
//     pageChangeCallback(int page) {
//     print( page );
//   }

//   updateTypeCallback( UpdateType updateType) {
//     print( updateType );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.white, blurRadius: 5, spreadRadius: -8),
                ],
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
                    ]),
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: ClipPath(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logoblack.png',
                    width: 600,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.account_balance_outlined),
                      Text('Hola')
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
