import 'package:flutter_bloc_prac/features/social/domain/result/result.dart';

class Failure<T> implements Result<T>{
  final String? failureMessage;
  Failure({this.failureMessage});
}