  import 'package:flutter/material.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'screen/home_screen.dart';
  import 'screen/welcome_screen.dart';
  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: ThemeData(
            fontFamily: GoogleFonts.notoSansTc().fontFamily,
            // textTheme: GoogleFonts.notoSansTcTextTheme(
            //   Theme.of(context).textTheme,
            // ),
          ),
          initialRoute: '/',
          routes: {
            '/welcome': (context) => const WelcomeScreen(),
            '/': (context) => const HomeScreen(),
          },
        ),
      );
    }
  }