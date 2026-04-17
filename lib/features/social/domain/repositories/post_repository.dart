import 'package:flutter_bloc_prac/features/social/domain/result/result.dart';

abstract class PostRepository {
  Future<Result> fetchPosts();
}
