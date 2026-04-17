import 'package:flutter_bloc_prac/core/utils/logger/pretty_logger.dart';
import 'package:flutter_bloc_prac/features/social/domain/repositories/post_repository.dart';
import 'package:flutter_bloc_prac/features/social/domain/result/failure.dart';
import 'package:flutter_bloc_prac/features/social/domain/result/result.dart';

class PostUseCase with PrettyLogger{
  final PostRepository _postRepository;

  PostUseCase(this._postRepository);

  Future<Result> fetchPosts() async {
    try {
      return await _postRepository.fetchPosts();
    } catch (exception, stackTrace) {
      errorLogger(message: exception, stackTrace: stackTrace);
    }
    return Failure(failureMessage: "Something went wrong");
  }
}
