import 'package:bucket_list_with_provider/bucket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider( // 위젯트리 꼭대기에 배치 (MyApp()보다 상위)
      providers: [
        ChangeNotifierProvider(create: (context) => BucketService())
      ],
      child: const MyApp(),
    ),
  );
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('1');
    return Consumer<BucketService>(
      builder: (context, bucketService, child) {
        print('2');
        // bucketService의 bucketList 가져오기
        List<Bucket> bucketList = bucketService.bucketList;
        return Scaffold(
          appBar: AppBar(
            title: Text('버킷 리스트'),
          ),
          body: bucketList.isEmpty // 버킷 리스트 상태에 따라 다른 결과 보여주기
              ? Center(child: Text('버킷 리스트를 작성해 주세요'))
              : ListView.builder(
                  itemCount: bucketList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Bucket bucket = bucketList[index];
                    return ListTile(
                      title: Text(
                        bucket.job,
                        style: TextStyle(
                          fontSize: 20,
                          color: bucket.isDone ? Colors.grey : Colors.black,
                          decoration: bucket.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDeleteDialog(context, index);
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        // 아이템 클릭시
                        bucket.isDone = !bucket.isDone;
                        // 기존에 setState 안에서 이루어지는 작업을 Provider에서 진행
                        bucketService.updateBucket(bucket, index);
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              String job = await Navigator.push(
                // pop이 되는 순간까지 기다림
                context,
                MaterialPageRoute(builder: (_) => CreatePage()),
              );
              if (job != null) {
                // setState(() {
                //   // List에 추가한 후 화면 갱신
                //   Bucket newBucket = Bucket(job, false);
                //   bucketlist.add(newBucket);
                // });
              }
            },
            child: Icon(Icons.add),
          ),
        );
      }
    );
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('정말로 삭제하시겠습니까?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소')),
            TextButton(
                onPressed: () {
                  BucketService bucketService = context.read<BucketService>();
                  bucketService.deleteBucket(index);
                  // setState(() {
                  //   bucketlist.removeAt(index); // 삭제
                  // });
                  Navigator.pop(context);
                },
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.pink),
                ))
          ],
        );
      },
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
                    });
                    // BucketService 가져오기
                    BucketService bucketService = context.read<BucketService>();
                    bucketService.createBucket(job);
                    Navigator.pop(context); // 화면 종료
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
