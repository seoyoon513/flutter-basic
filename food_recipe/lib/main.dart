import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/food.dart';

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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.menu),
        //   color: Colors.black,
        // ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.perm_identity),
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
      drawer: Drawer(
        child: Column(
          // 1. Column 으로 설정
          children: [
            // 복수의 위젯 나열
            DrawerHeader(
              margin: EdgeInsets.all(0), //기본 마진값 제거
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Container(
                width: double.infinity, // header 가득 채우기
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Image.network(
                        "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                        width: 50,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '닉네임',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'hello@world.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // UserAccountsDrawerHeader(
            //   decoration: BoxDecoration(
            //     // Drawer head 디자인 변경
            //     color: Colors.amber,
            //   ),
            //   currentAccountPicture: CircleAvatar(
            //     backgroundImage:
            //         NetworkImage("https://i.ibb.co/CwzHq4z/trans-logo-512.png"),
            //   ),
            //   accountName: Text(
            //     '닉네임',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   accountEmail: Text(
            //     'hello@world.com',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Container(
              height: 100,
              child: PageView(
                children: [
                  Image.network(
                      "https://i.ibb.co/Q97cmkg/sale-event-banner1.jpg"),
                  Image.network(
                      "https://i.ibb.co/GV78j68/sale-event-banner2.jpg"),
                  Image.network(
                      "https://i.ibb.co/R3P3RHw/sale-event-banner3.jpg"),
                  Image.network(
                      "https://i.ibb.co/LRb1VYs/sale-event-banner4.jpg")
                ],
              ),
            ),
            ListTile(
              trailing: Icon(Icons.navigate_next), // 우측 끝에 아이콘 배치
              title: Text('구매내역'),
            ),
            ListTile(
              trailing: Icon(Icons.navigate_next),
              title: Text('저장한 레시피'),
            )
          ],
        ), // scaffold의 named argument이므로 appBar에서 나와서 작성
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                // 디자인 관련
                border: OutlineInputBorder(), // 테두리
                labelText: '상품을 검색해주세요.',
                suffixIcon: IconButton(
                  // 우측 아이콘 배치
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            Divider(height: 1),
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length, // 리스트 크기 만큼 반복
                itemBuilder: (context, index) {
                  String image = dataList[index]["imgUrl"];
                  String category = dataList[index]["category"];
                  return Food(imageUrl: image, category: category);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
