import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
    required this.imageUrl // 2. Feed() 호출할 때 값 할당
  }) : super(key: key);

  final String imageUrl; // 1. 이미지를 담을 변수,  3. 생성자 호출 시 받은 이미지를 변수에 저장

  @override
  State<Feed> createState() => _FeedState();
}

//'_'로 시작하는 이름 : 외부 파일에서 접근할 수 없는 private
class _FeedState extends State<Feed> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 정렬
      children: [
        Image.network(
          widget.imageUrl, // 4. 변수를 상태 클래스에서 접근 (wiget.변수명)
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover, // 이미지의 비율을 유지하면서 고정된 폭과 높이에 맞추어 이미지를 자른다
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.heart,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.black,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bookmark,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "2 likes",
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cat is docile even when bathed. I put a duck on his head in the wick and he's staring at me. Isn't it so cute??",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "FEBRUARY 6",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}