import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double imageOpacity = 0.0;
  double textOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    
    // 延遲一下後開始圖片淡入動畫
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          imageOpacity = 1.0;
        });
        
        // 圖片淡入完成後（2秒後）開始文字淡入
        Future.delayed(Duration(milliseconds: 2000), () {
          if (mounted) {
            setState(() {
              textOpacity = 1.0;
            });
          }
        });

        // 文字淡入完成後（2秒後）開始跳轉
        Future.delayed(Duration(milliseconds: 5000), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  opacity: imageOpacity,
                  duration: Duration(milliseconds: 1000),
                  child: Image.asset('assets/images/icon.png', width: 100.w),
                ),
                SizedBox(height: 20.w),
                AnimatedOpacity(
                  opacity: imageOpacity,
                  duration: Duration(milliseconds: 1000),
                  child: Image.asset('assets/images/logo.png', width: 300.w),
                ),
                SizedBox(height: 20.w),
                AnimatedOpacity(
                  opacity: textOpacity,
                  duration: Duration(milliseconds: 1000),
                  child: Text(
                    '保護每一位勞工的權益', 
                    style: TextStyle(
                      fontSize: 20.sp,
                      // fontFamily: GoogleFonts.notoSansTc().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
