import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/widget/change_theme_button_widget.dart';
import 'package:hexcolor/hexcolor.dart';




class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBodyBehindAppBar: true,
    extendBody: true,
    appBar: AppBar( 
      automaticallyImplyLeading: false,
       backgroundColor: Colors.transparent,
       elevation: 0,
    ),
    body: ListView(
      padding: EdgeInsets.only(top: 0),
      children: [
        buildProfile( context),
        infoProfile(),
        settings()
      ],
    )
    );
}

   Widget buildProfile(BuildContext context){
    return Stack(
      clipBehavior: Clip.none,
      children: [   
          ClipPath(
            child: Container(
             height: 348,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow( color: Colors.white, blurRadius: 5, spreadRadius: -8),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end:  Alignment.topRight,
                stops: [ 0.1, 0.80,],
                colors:[
                 HexColor('00ff00'),
                HexColor('05d0ae'),
              ] ),
             
            ),
          ),
        ),
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(     
          height: 349,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow( color: Colors.white, blurRadius: 5, spreadRadius: -8),
            ],
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 60,
          child: Center(
           child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              boxShadow: [
                  BoxShadow( color: Colors.white, blurRadius: 5, spreadRadius: -8),    
                ],
                image: DecorationImage(
                image: AssetImage('assets/avatar.png'),
                fit: BoxFit.cover,
              )
            ),
          )
         )  
        ),
        Positioned(
          bottom: -10,
          child: Column(children: [
            SizedBox(
              width: 200,
              child: Text(
                'Alejandro Fernandez',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                 fontSize: 18
                ),
              ),
            ),
             SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'jalejandrofdz24@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                ),
              ),
            )
          ],
        )
      ),  
      ],   
    );
   }
}
class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
      var path =new Path()
     ..moveTo(size.width, 130)
     ..lineTo(size.width, size.height)
     ..lineTo(0, size.height) ;
      return  path;
  }
  @override 
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

Widget infoProfile(){
return Container(
  padding: EdgeInsets.only(top: 25),
  child: Center(
    child: Column(
      
     children: [
       
       ListTile(
         contentPadding: EdgeInsets.only(top: 1, left: 40),
         leading: Icon(Icons.calendar_today),
         title: Text('Join Date' ),
         subtitle: Text('24 Feb 2021'),
       ),
       Divider(),
       ListTile(
        
        contentPadding: EdgeInsets.only(top: -100, left: 40),
         leading: Icon(Icons.celebration),
         title: Text('Total added Stickers'),
         subtitle: Text('33'),
       ),
       Divider(),
     ],
    ),
  ),
);
}

Widget settings(){
  return Container(
    child: Center(
      child: Column(
        children: [
          Title(
            color: Colors.black, 
            child: Text(
              'Settings', 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold)
                )
              ),

              ChangeThemeButtonWidget(),
             

          ListTile(
         leading: Icon(Icons.toc_outlined),
         title: Text('Privacity Police' ),
        
       ),
       
       ListTile(
         leading: Icon(Icons.assignment_ind_outlined),
         title: Text('Terms of use'),
       ),
         ListTile(
         leading: Icon(Icons.logout_outlined),
         title: Text('Logout '),
       ),
     

        ],
      ),
    ),
  );
}
