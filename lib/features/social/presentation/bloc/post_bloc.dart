import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/core/utils/logger/pretty_logger.dart';
import 'package:flutter_bloc_prac/features/social/domain/result/failure.dart';
import 'package:flutter_bloc_prac/features/social/domain/result/success.dart';
import 'package:flutter_bloc_prac/features/social/presentation/bloc/post_event.dart';
import 'package:flutter_bloc_prac/features/social/presentation/bloc/post_state.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../domain/result/result.dart';
import '../../domain/use_cases/post_use_case.dart';

class PostBloc extends Bloc<PostEvent, PostState> with PrettyLogger {
  final PostUseCase _postUseCase;

  PostBloc(this._postUseCase) : super(PostState(postList: [])) {
    on<FetchPosts>(_fetchPosts);
  }

  Future<void> _fetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    if (state.postStatus == PostStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(postStatus: PostStatus.loading));
      Result result = await _postUseCase.fetchPosts();
      if (result is Failure) {
        emit(state.copyWith(postStatus: PostStatus.failure));
      } else {
        emit(
          state.copyWith(
            postStatus: PostStatus.success,
            postEntity: (result as Success).data,
          ),
        );
      }
    } catch (exception, stackTrace) {
      errorLogger(message: exception, stackTrace: stackTrace);
    }
  }
}
