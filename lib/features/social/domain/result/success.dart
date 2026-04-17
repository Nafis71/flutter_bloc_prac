import 'package:flutter_bloc_prac/features/social/domain/result/result.dart';

class Success<T> implements Result<T>{
  final T? data;
  Success({this.data});
}