import 'package:bucket_list_with_provider/main.dart';
import 'package:flutter/material.dart';

class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기', false)
  ];
}