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

class Bucket {
  String job; // 할 일
  bool isDone; // 완료 여부

  Bucket(this.job, this.isDone); // 생성자
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Bucket> bucketlist = []; // 전체 버킷 리스트 목록

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
                Bucket bucket = bucketlist[index];
                return ListTile(
                  title: Text(
                    bucket.job,
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
                    bucket.isDone = !bucket.isDone; // isDone 상태 변경
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String job = await Navigator.push( // pop이 되는 순간까지 기다림
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );
          if (job != null) {
            setState(() { // List에 추가한 후 화면 갱신
              Bucket newBucket = Bucket(job, false);
              bucketlist.add(newBucket);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  String? error;

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
              controller: textController,
              autofocus: true, // 자동 포커스
              decoration: InputDecoration(
                hintText: '하고 싶은 일을 입력하세요',
                errorText: error,
              ),
            ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      // 상태 변경한 경우 setState()를 이용하여 갱신
                      error = '내용을 입력해주세요.';
                    });
                  } else {
                    setState(() {
                      error = null;
                      Navigator.pop(context, job); // 화면 종료 및 데이터 전달
                    });
                  }
                },
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
