import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  const Feed({
    required this.imageUrl,
    required this.category,
    super.key,
  });

  final String imageUrl;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Container(
          height: 120,
          decoration: BoxDecoration(
            // Container 위젯 디자인 커스텀
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), // 투명도 설정
                BlendMode.darken,
              ),
              image: NetworkImage( // 배경 이미지
                imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center( // center로 감싸지 않으면 text너비에 맞게 이미지가 줄어듦
            child: Text(
              category,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        )
        // ListView.builder(
        //   itemCount: dataList.length,
        //   itemBuilder: (BuildContext context, int index) {  },
        // )
      ],
    );
  }
}