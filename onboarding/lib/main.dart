import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 늦은 초기화, 무조건 값을 넣고 호출 해야함
late SharedPreferences prefs; // 전역 변수 선언

Future<void> main() async {
  // main 함수에서 async를 쓰려면 필요함
  WidgetsFlutterBinding.ensureInitialized();

  // shared_preferences 인스턴스 생성
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SharedPreferences에서 온보딩 완료 여부 조회
    // isOnboarding에 해당하는 값에서 null을 반환하는 경우 false 할당
    bool isOnboarded = prefs.getBool("isOnboarded") ?? false;
    return MaterialApp(
      theme: ThemeData(
        // 전역적으로 폰트 변경
        textTheme: GoogleFonts.getTextTheme('Jua'), // 인터넷 통해 폰트 다운로드
      ),
      debugShowCheckedModeBanner: false,
      home: isOnboarded ? HomePage() : OnboardingPage(),
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
        prefs.setBool("isOnboarded", true);
        Navigator.pushReplacement(
            // 현재 페이지 없애고 다른 페이지 띄우기
            context,
            MaterialPageRoute(builder: (context) => HomePage()));
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
        actions: [
          IconButton(
            onPressed: () {
              prefs.clear();
            },
            icon: Icon(Icons.delete),
          )
        ],
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
