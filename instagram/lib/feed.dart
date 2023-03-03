import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  const Feed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 정렬
      children: [
        Image.network(
          "https://cdn2.thecatapi.com/images/kat_7kqBi.png",
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