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
            title: "빠른 개발",
            body: "Flutter의 hot reload는 쉽고 UI 빌드를 도와줍니다.",
            image: Padding(
              padding: const EdgeInsets.all(32),
              child: Image.network(
                "https://user-images.githubusercontent.com/26322627/143761841-ba5c8fa6-af01-4740-81b8-b8ff23d40253.png",
              ),
            ),
            decoration: PageDecoration(
                titleTextStyle: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                bodyTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ))),

        // 페이지 2
        PageViewModel(
          title: "표현력 있고 유연한 UI",
          body: "Flutter에 내장된 아름다운 위젯들로 사용자를 기쁘게 하세요.",
          image: Image.network(
              'https://user-images.githubusercontent.com/26322627/143762620-8cc627ce-62b5-426b-bc81-a8f578e8549c.png'),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              color: Colors.blueAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],

      // 필수 파라미터
      next: Text("Next"),
      done: Text("Done"),
      onDone: () {
        // when done button is pressed
        Navigator.pushReplacement( // 현재 페이지 없애고 다른 페이지 띄우기
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
    ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page!"),
      ),
      body: Center(
        child: Text(
          "환영합니다!",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
