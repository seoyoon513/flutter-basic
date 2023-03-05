import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  List<String> bucketlist = ['여행가기', '밥먹기', '잠자기']; // 전체 버킷 리스트 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버킷 리스트'),
      ),
      body: bucketlist.isEmpty // 버킷 리스트 상태에 따라 다른 결과 보여주기
          ? Center(child: Text('버킷 리스트를 작성해 주세요'))
          : ListView.builder(
              itemCount: bucketlist.length,
              itemBuilder: (BuildContext context, int index) {
                String bucket = bucketlist[index];
                return ListTile(
                  title: Text(
                    bucket,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      print('$bucket : 삭제하기');
                    },
                    icon: Icon(
                      CupertinoIcons.delete,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    // 아이템 클릭시
                    print('$bucket : 클릭 됨');
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreatePage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버킷 리스트 작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              autofocus: true, // 자동 포커스
              decoration: InputDecoration(hintText: '하고 싶은 일을 입력하세요'),
            ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '추가하기',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
