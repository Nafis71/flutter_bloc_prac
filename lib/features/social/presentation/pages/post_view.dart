import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/core/utils/enums/enums.dart';
import 'package:flutter_bloc_prac/features/social/domain/entities/post_entity.dart';
import 'package:flutter_bloc_prac/features/social/presentation/bloc/post_bloc.dart';
import 'package:flutter_bloc_prac/features/social/presentation/bloc/post_state.dart';

import '../bloc/post_event.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late final PostBloc _postBloc;

  @override
  void initState() {
    _postBloc = context.read<PostBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postBloc.add(FetchPosts());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Post Dummy",
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.postStatus == PostStatus.loading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              final PostEntity postEntity = state.postList[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                title: Text(
                  postEntity.title ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  postEntity.body ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
            itemCount: state.postList.length,
          );
        },
      ),
    );
  }
}
