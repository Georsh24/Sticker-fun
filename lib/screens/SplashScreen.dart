import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/screens/login_screen.dart';
import 'package:hexcolor/hexcolor.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 2), (){
    //    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
       
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

          children: [ClipPath(
          child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow( color: Colors.white, blurRadius: 5, spreadRadius: -8),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end:  Alignment.bottomRight,
                stops: [ 0.1, 0.60,],
                colors:[
                HexColor('00ff00'),
                HexColor('05d0ae'),
              ] ),
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
            
              Image.asset('assets/logoblack.png', width: 600,),
              SizedBox(height: 20,),
              //CircularProgressIndicator()
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
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                  child: Row(
                    children: [
                      Icon(Icons.account_balance_outlined),
                      Text('Hola')
                    ],
                  ),
                )
          //       // // Container(
          //       // //   width: 300,    
          //       // //   // child: ElevatedButton(
          //       // //   //   child: Text('Bienvenido'),   
          //       // //   //   onPressed: (){
          //       // //   //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          //       // //   //   },       
          //       // //   //   )    
          //       //     ),
              ],
             ),
           ),
        ],
      ),
    );
  }
}