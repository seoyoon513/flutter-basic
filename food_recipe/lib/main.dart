import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feed.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // 홈페이지 보여주기
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 음식 사진 데이터
    List<Map<String, dynamic>> dataList = [
      {
        "category": "수제버거",
        "imgUrl":
            "https://image.edaily.co.kr/images/photo/files/NP/S/2022/04/PS22040800131.jpg",
      },
      {
        "category": "건강식",
        "imgUrl":
            "https://src.hidoc.co.kr/image/lib/2020/6/23/1592877797677_0.jpg",
      },
      {
        "category": "한식",
        "imgUrl":
            "https://image.ajunews.com/content/image/2018/07/25/20180725142544658121.jpg",
      },
      {
        "category": "디저트",
        "imgUrl":
            "https://cdn.thescoop.co.kr/news/photo/201902/33977_43235_210.jpg",
      },
      {
        "category": "피자",
        "imgUrl":
            "https://src.hidoc.co.kr/image/lib/2020/6/17/1592363657269_0.jpg",
      },
      {
        "category": "볶음밥",
        "imgUrl":
            "https://www.sbfoods-worldwide.com/ko/recipes/qfttv70000001txe-img/9_FriedRice_L.png",
      },
    ];

    // 화면에 보이는 영역
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.perm_identity),
            color: Colors.black,
          )
        ],
        title: Text(
          'Food Recipe',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Feed(
          imageUrl: dataList[1]["imgUrl"],
          category: dataList[1]["category"],
        ),
      ),
    );
  }
}
