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

  // 좋아요 사진
  List<String> favoriteImages = [];

  CatService() {
    getRandomCatImages();
  }

  // 랜덤 고양이 사진 API 호출
  void getRandomCatImages() async {
    Response result = await Dio().get(
      "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg",
    );
    print(result.data);
    for (var i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      print(map);
      print(map["url"]);
      catImages.add(map["url"]);
    }
    notifyListeners();
  }

  void toggleFavoriteImage(String catImage) {
    if (favoriteImages.contains(catImage)) {
      favoriteImages.remove(catImage); // 이미 좋아요한 경우 삭제
    } else {
      favoriteImages.add(catImage); // 추가
    }
    notifyListeners(); // Consumer 아래 빌더 부분이 다시 실행 -> 새로고침
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(builder: (context, catService, child) {
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
          padding: EdgeInsets.all(8),
          // 바깥쪽 테두리
          children: List.generate(
            catService.catImages.length, // 원소의 크기
            (index) {
              String catImage = catService.catImages[index];
              return GestureDetector(
                onTap: () {
                  catService.toggleFavoriteImage(catImage);
                },
                child: Stack(
                  // 1. stack 안에 있는 child는 기본으로 화면을 꽉 채우지 않는다
                  children: [
                    Positioned.fill(
                      // 2. 따라서 Positioned.fill 위젯으로 감싸야 한다
                      child: Image.network(
                        catImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Icon(
                        Icons.favorite,
                        color: catService.favoriteImages.contains(catImage)
                            ? Colors.amber
                            : Colors.transparent,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
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
