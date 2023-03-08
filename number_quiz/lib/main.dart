import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Numbers API 호출하기
  Future<String> getNumberTrivia() async {
    // get 메서드로 URL 호출
    Response result = await Dio().get('http://numbersapi.com/random/trivia');
    String trivia = result.data; // 응답 결과 가져오기
    print(trivia);
    return trivia; // 결과 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                // 화면 안에서 최대한 펼쳐지기
                child: Center(
              child: Text(
                '퀴즈',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            )),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  getNumberTrivia();
                },
                child: Text(
                  'New Quiz',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 24,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
