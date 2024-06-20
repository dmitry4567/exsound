class Account {
  final String nickname;
  final String name;
  final String email;
  final bool notification;

  const Account({
    required this.nickname,
    required this.name,
    required this.email,
    required this.notification,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      nickname: json['nickname'] as String,
      name: json['fullname'] as String,
      email: json['email'] as String,
      notification: json.containsKey('token') ? true : false,
    );
  }
}
