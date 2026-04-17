class PostEntity{
  int? id;
  int? userId;
  String? title;
  String? body;

  PostEntity({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  @override
  String toString() {
    return 'PostEntity{id: $id, userId: $userId, title: $title, body: $body}';
  }
}