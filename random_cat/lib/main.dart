import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CatService(),
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
