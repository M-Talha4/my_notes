import 'dart:async';

import 'package:database/screens/background/bg_splash.dart';
import 'package:database/screens/home_screen.dart';
import 'package:database/utils/colors.dart';
import 'package:database/widgets/ctext.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [secondaryColor, primaryColor]),
          ),
          child: Stack(
            children: [
              BackgroundSplash(height: height, width: width),
              Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  height: height * 0.4,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    children: [
                      cText(
                        text: 'My Notes!',
                        color: Colors.white,
                        size: width * 0.11,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: width * 0.3,
                        height: height * 0.08,
                        child: Divider(
                          color: splashDivider,
                          height: height * 0.03,
                          thickness: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const cText(
                        text:
                            '“In the meantime, keep a small spiral notebook, a pen, and a little flashlight on your bedside table, and jot down things as they come to you.”',
                        color: Colors.white,
                        weight: FontWeight.bold,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
