import 'package:bucket_list_with_provider/main.dart';
import 'package:flutter/material.dart';

class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기', false)
  ];

  // Bucket 추가
  void createBucket(String job) { // 1. String을 받아서
    // 2. Bucket 인스턴스를 만들어 bucketList에 추가
    bucketList.add(Bucket(job, false));
    // 변경사항이 있는 경우 새로고침
    // Consumer<BucketService>의 builder부분만 새로고침 
    notifyListeners();
  }
}