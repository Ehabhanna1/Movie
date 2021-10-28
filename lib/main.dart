import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/HomeScreens/Home_Screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.arvoTextTheme(Theme.of(context).textTheme),

        primarySwatch: Colors.red,
      ),
      home:AnimatedSplashScreen(
        backgroundColor: Colors.black,
        duration: 4000,
        splash:Image.asset("images/Netflix Splash Screen.gif",
        height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ) ,
        splashIconSize: double.infinity,
        nextScreen:HomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
    );
  }
}

