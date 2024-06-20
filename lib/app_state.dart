import 'package:exstudio/flutter_flow/UserInfo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _userAuthToken = prefs.getString('ff_user_auth_token') ?? _userAuthToken;
    _refreshToken = prefs.getString('ff_refresh_token') ?? _refreshToken;
    _user = await getUserData(prefs);
  }

  Future<UserInfo> getUserData(SharedPreferences prefs) async {
    return UserInfo(
      id: prefs.getString('ff_id') ?? _user.id,
      fullname: prefs.getString('ff_fullname') ?? _user.fullname,
    );
  }

  Future clearDataUser() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  UserInfo _user = UserInfo(
    id: "",
    fullname: "",
  );

  UserInfo get user {
    return _user;
  }

  set user(UserInfo value) {
    _user = value;
    print(value);
    prefs.setString("ff_id", value.id);
    prefs.setString("ff_fullname", value.fullname);
  }

  late SharedPreferences prefs;

  String _userAuthToken = "";

  String get userAuthToken {
    return _userAuthToken;
  }

  Future<void> setUserAuthToken(String value) async {
    _userAuthToken = value;
    await prefs.setString("ff_user_auth_token", value);
  }

  String _refreshToken = "";

  String get refreshToken {
    return _refreshToken;
  }

  Future<void> setRefreshToken(String value) async {
    _refreshToken = value;
    await prefs.setString("ff_refresh_token", value);
  }

  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  List<dynamic> workoutResults = [];
}
