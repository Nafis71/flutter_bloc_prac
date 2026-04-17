import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_prac/features/social/domain/entities/post_entity.dart';
import '../../../../core/utils/enums/enums.dart';

class PostState extends Equatable {
  final PostStatus? postStatus;
  final List<PostEntity> postList;

  @override
  List<Object?> get props => [postStatus, postList];

  const PostState({
    this.postStatus, required this.postList,
  });

  PostState copyWith({
    PostStatus? postStatus,
    List<PostEntity>? postEntity,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      postList: postEntity ?? this.postList,
    );
  }
}
