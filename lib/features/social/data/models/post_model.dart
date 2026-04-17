import 'package:flutter_bloc_prac/features/social/domain/entities/post_entity.dart';

class PostModel extends PostEntity{
  PostModel({super.body, super.id, super.title, super.userId});

  factory PostModel.fromJson(Map<String,dynamic> json){
    return PostModel(
      body: json['body'],
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }
}