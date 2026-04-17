import 'package:flutter_bloc_prac/core/controller/network_controller.dart';
import 'package:flutter_bloc_prac/core/utils/enums/enums.dart';
import 'package:flutter_bloc_prac/features/social/data/config/api_endpoints.dart';
import 'package:flutter_bloc_prac/features/social/data/repositories/api_response.dart';
import 'package:flutter_bloc_prac/features/social/data/response/success_response.dart';
import 'package:flutter_bloc_prac/features/social/domain/entities/post_entity.dart';
import 'package:flutter_bloc_prac/features/social/domain/result/failure.dart';
import 'package:flutter_bloc_prac/features/social/domain/result/result.dart';

import '../../domain/repositories/post_repository.dart';
import '../../domain/result/success.dart';
import '../models/post_model.dart';

class PostRequest implements PostRepository {
  final NetworkController _networkController;

  PostRequest(this._networkController);

  @override
  Future<Result> fetchPosts() async {
    final ApiResponse response = await _networkController.request(
      requestMethod: RequestMethod.get,
      endpoint: ApiEndpoints.post,
    );
    if (response is SuccessResponse) {
      return Success(
        data: List<PostEntity>.from(
          (response.data as List).map((element) => PostModel.fromJson(element)),
        ),
      );
    }
    return Failure(failureMessage: "Failed to fetch posts at the moment");
  }
}
