class StudioSessions {
  final int id;
  final String nameTrack;
  final int from;
  final int until;
  // final TypeOfActivity typeOfActivity;
  // final Users userAdmins;
  // final Users userClients;

  const StudioSessions({
    required this.id,
    required this.nameTrack,
    required this.from,
    required this.until,
    // required this.typeOfActivity,
    // required this.userAdmins,
    // required this.userClients,
  });

  factory StudioSessions.fromJson(Map<String, dynamic> json) {
    return StudioSessions(
      id: json['id'] as int,
      nameTrack: json['name_track'] as String,
      from: json['from'] as int,
      until: json['untill'] as int,
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
