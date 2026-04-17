import 'package:flutter_bloc_prac/features/social/data/repositories/api_response.dart';

class FailureResponse<T> implements ApiResponse<T> {
  final int? statusCode;
  final String? message;
  FailureResponse({this.statusCode, this.message});
}