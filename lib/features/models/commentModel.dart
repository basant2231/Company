class Comment {
  String? commentId;
   String? commentBody;
  String? commenterId;
  String? commenterName;
  String? commenterImageUrl;

  Comment(
      {required this.commentBody,
      this.commenterName,
      this.commentId,
      this.commenterId,
      this.commenterImageUrl});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'] as String,
      commentBody: json['commentBody'] as String,
      commenterId: json['commenterId'] as String,
      commenterName: json['commenterName'] as String,
      commenterImageUrl: json['commenterImageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'commentBody': commentBody,
      'commenterId': commenterId,
      'commenterName': commenterName,
      'commenterImageUrl': commenterImageUrl,
    };
  }
}
