import 'package:bucket_list_with_provider/main.dart';
import 'package:flutter/material.dart';

class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기', false)
  ];

  // bucket 추가
  void createBucket(String job) { // 1. String을 받아서
    // 2. Bucket 인스턴스를 만들어 bucketList에 추가
    bucketList.add(Bucket(job, false));
    // 변경사항이 있는 경우 새로고침
    // Consumer<BucketService>의 builder부분만 새로고침
    notifyListeners();
  }

  // bucket 수정
  void updateBucket(Bucket bucket, int index) {
    // 인덱스에 해당하는 버킷 리스트에 전달받은 버킷 넣기
    bucketList[index] = bucket;
    notifyListeners();
  }

  // bucket 삭제
  void deleteBucket(int index) {
    bucketList.removeAt(index);
    notifyListeners();
  }
}