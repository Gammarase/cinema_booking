import 'package:cinema_booking/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.id,
    super.author,
    required super.content,
    required super.rating,
    required super.isMy,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json['id'],
        author: json['author'],
        content: json['content'],
        rating: json['rating'],
        isMy: json['isMy']);
  }
}
