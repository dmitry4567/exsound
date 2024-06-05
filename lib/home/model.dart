class Project {
  final int id;
  final String description;
  final List<Photo> photos;
  List<Like> likes;
  final Author author;
  int likesCount;

  Project({
    required this.id,
    required this.description,
    required this.photos,
    required this.author,
    required this.likesCount,
    required this.likes,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
      id: json['id'],
      description: json['description'],
      photos: List<Photo>.from(
        json['photoItems'].map((photo) => Photo.fromJson(photo)),
      ),
      likes: List<Like>.from(
        json['likes'].map((like) => Like.fromJson(like)),
      ),
      author: Author.fromJson(json['author']),
      likesCount: json['likesCount']);
}

class Photo {
  final int id;
  final String fileName;

  Photo({
    required this.id,
    required this.fileName,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json['id'],
        fileName: json['fileName'],
      );
}

class Like {
  final String userId;

  Like({
    required this.userId,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        userId: json['user']['id'].toString(),
      );
}

class Author {
  final String nickname;
  final String avatarUrl;

  Author({
    required this.nickname,
    required this.avatarUrl,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        nickname: json['nickname'],
        avatarUrl: json['avatarUrl'],
      );
}
