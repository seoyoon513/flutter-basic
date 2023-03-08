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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quiz = "";

  @override
  void initState() { // 1. async, await를 사용할 수 없다
    super.initState();
    print('시작');
    getQuiz();
  }

  // 퀴즈 가져오기
  Future<void> getQuiz() async { // 2. 함수로 따로 만들어서 실행
    String trivia = await getNumberTrivia();
    setState(() {
      quiz = trivia;
    });
  }

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
      backgroundColor: Colors.pinkAccent,
      body: SafeArea( // 기기로 인해 가려지는 부분 띄우기
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  // 화면 안에서 최대한 펼쳐지기
                  child: Center(
                child: Text(
                  quiz,
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
                    getQuiz();
                  },
                  child: Text(
                    'New Quiz',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 24,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
