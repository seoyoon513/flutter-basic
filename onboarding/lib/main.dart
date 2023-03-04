import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          // 페이지 1
          PageViewModel(
            title: "title1",
            bodyWidget: Text("body1")
          ),

          // 페이지 2
          PageViewModel(
            title: "title2",
            bodyWidget: Text("body2")
          )
        ],

        // 필수 파라미터
        next: Text("Next"),
        done: Text("Done"),
        onDone: () {
          // when done button is pressed
        },
      )
    );
  }
}
