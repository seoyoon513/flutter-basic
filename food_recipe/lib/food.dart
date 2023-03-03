import 'package:flutter/material.dart';

class Food extends StatelessWidget {
  const Food({
    super.key,
    required this.imageUrl,
    required this.category,
  });

  final String imageUrl;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
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
    );
  }
}