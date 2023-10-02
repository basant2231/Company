class Comment {
  String? commentId;
  String? commentBody;
  String? commenterId;
  String? commenterName;
  String? commenterImageUrl;
  dynamic? timestamp; // Add timestamp field here

  Comment({
    required this.commentBody,
    this.commenterName,
    this.commentId,
    this.commenterId,
    this.commenterImageUrl,
    this.timestamp, // Include timestamp in the constructor
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'] as String,
      commentBody: json['commentBody'] as String,
      commenterId: json['commenterId'] as String,
      commenterName: json['commenterName'] as String,
      commenterImageUrl: json['commenterImageUrl'] as String,
      timestamp: json['timestamp'] as String, // Parse timestamp from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'commentBody': commentBody,
      'commenterId': commenterId,
      'commenterName': commenterName,
      'commenterImageUrl': commenterImageUrl,
      'timestamp': timestamp, // Include timestamp in JSON serialization
    };
  }
}
