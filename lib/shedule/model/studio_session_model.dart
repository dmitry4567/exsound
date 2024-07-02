class StudioSessions {
  final int id;
  final String nameTrack;
  final DateTime from;
  final DateTime until;
  final TypeOfActivity typeOfActivity;
  final List<User> userAdmins;
  final List<User> userClients;

  const StudioSessions({
    required this.id,
    required this.nameTrack,
    required this.from,
    required this.until,
    required this.typeOfActivity,
    required this.userAdmins,
    required this.userClients,
  });

  factory StudioSessions.fromJson(Map<String, dynamic> json) {
    return StudioSessions(
      id: json['id'] as int,
      nameTrack: json['name_track'] ?? "",
      from: DateTime.parse(json['from']),
      until: DateTime.parse(json['until']),
      typeOfActivity: TypeOfActivity.fromJson(json['type_of_activity']),
      userAdmins: List<User>.from(
        json['user_admins'].map((user) => User.fromJson(user)),
      ),
      userClients: List<User>.from(
        json['user_clients'].map((user) => User.fromJson(user)),
      ),
    );
  }
}

class TypeOfActivity {
  final String name;

  TypeOfActivity({required this.name});

  factory TypeOfActivity.fromJson(Map<String, dynamic> json) {
    return TypeOfActivity(
      name: json['name'] as String,
    );
  }
}

class User {
  final int id;
  final String nickname;

  const User({
    required this.id,
    required this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
    );
  }
}
