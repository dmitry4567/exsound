class UserInfo {
  final String id;
  final String fullname;

  UserInfo({
    required this.id,
    required this.fullname,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
    };
  }

  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullname = json['fullname'];

  @override
  String toString() {
    return 'id: $id \nfullname: $fullname';
  }
}
