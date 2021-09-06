import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/screens/HomeScreen.dart';
import 'package:flutter_stickers_internet/screens/CheckAuthScreen.dart';
import 'package:flutter_stickers_internet/screens/LoginScreen.dart';
import 'package:flutter_stickers_internet/screens/RegisterScreen.dart';
import 'package:flutter_stickers_internet/services/AuthService.dart';
import 'package:flutter_stickers_internet/services/Services.dart';
import 'package:provider/provider.dart';
import 'provider/ThemeProvider.dart';
import 'screens/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
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
      initialRoute: 'checking',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
        'register': (_) => RegisterScreen(),
        'checking': (_) => CheckAuthScreen(),
        'splashscreen': (_) => SplashScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Trendy Stickers - Whatsapp Stickers',
      theme: MyThemes.lightTheme,
      themeMode: themeProvider.themeMode,
      darkTheme: MyThemes.darkTheme,
    );
  }
}
