import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:trendy_stickers/screens/SplashScreen.dart';
//import 'package:trendy_stickers/provider/theme_provider.dart';

import 'provider/theme_provider.dart';
import 'screens/SplashScreen.dart';
//import 'ui/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        //ChangeNotifierProvider(create: (_) => StickerListModel()),
       // ChangeNotifierProvider(create: (_) => InstallStickersModal()),
      ],
      child: MaterilAppTheme(),
    );
  }
}

class MaterilAppTheme extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
   final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trendy Stickers - Whatsapp Stickers',
      theme: MyThemes.lightTheme,
      themeMode: themeProvider.themeMode,
      darkTheme: MyThemes.darkTheme,
      home: SplashScreen(),
      
      
    );
  }
}
