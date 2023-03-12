import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CatService(), // 생성자 호출 부분
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class CatService extends ChangeNotifier {
  // 고양이 사진 담을 변수
  List<String> catImages = [];

  CatService() {
    getRandomCatImages();
  }

  void getRandomCatImages() async {
    Response result = await Dio().get(
      "https://api.thecatapi.com/v1/images/search?limit=1&mime_types=jpg",
    );
    print(result.data);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text('랜덤 고양이'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritePage(),
                    ),
                  );
                },
                icon: Icon(CupertinoIcons.heart_fill),
              )
            ],
          ),
          body: GridView.count(
            // 자동 스크롤
            mainAxisSpacing: 8,
            // 아래와의 간격
            crossAxisSpacing: 8,
            // 양옆으로 간격
            crossAxisCount: 2,
            padding: EdgeInsets.all(16),
            // 바깥쪽 테두리
            childAspectRatio: 8.0 / 9.0,
            // 카드 비율
            children: List.generate(
              10, // 원소의 크기
              (index) {
                return Center(
                  child: Text(
                    "$index",
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
}

// 좋아요 페이지
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("좋아요"),
            backgroundColor: Colors.amber,
          ),
        );
      }
    );
  }
}
