import 'package:flutter_bloc_prac/features/social/data/repositories/api_response.dart';

class SuccessResponse<T> implements ApiResponse<T>{
  final T? data;
  SuccessResponse({this.data});
}