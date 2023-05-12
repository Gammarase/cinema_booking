class Comment {
  int id;
  String? author;
  String? content;
  int rating;
  bool isMy;

  Comment({
    required this.id,
    this.author,
    required this.content,
    required this.rating,
    required this.isMy,
  });
}
