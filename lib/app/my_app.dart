import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/provider/ThemeProvider.dart';
import 'package:flutter_stickers_internet/app/services/AuthService.dart';
import 'package:flutter_stickers_internet/app/services/NotificationsService.dart';
import 'package:flutter_stickers_internet/app/ui/routes/app_routes.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_meedu/router.dart' as router;

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
      title: 'Sticker Fun',
      navigatorKey: router.navigatorKey,
      initialRoute: Routes.SPLASH,
      navigatorObservers: [
        router.observer
      ],
      routes: appRoutes,
      // routes: {
      //   'login': (_) => LoginScreen(),
      //   'home': (_) => HomeScreen(),
      //   'register': (_) => RegisterScreen(),
      //   'checking': (_) => CheckAuthScreen(),
      //   'splashscreen': (_) => SplashScreen(),
      // },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      debugShowCheckedModeBanner: false,
    
      theme: MyThemes.lightTheme,
      themeMode: themeProvider.themeMode,
      darkTheme: MyThemes.darkTheme,
    );
  }
}
