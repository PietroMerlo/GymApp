import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile extends StateNotifier<UserData?> {
  UserProfile(super.state);

  void login(String user, String psw) {
    state = UserData(user, psw);
  }

  void logout() {
    state = null;
  }
}

class UserData {
  final String Username;
  final String Password;

  const UserData(this.Username, this.Password);

  String getUsername() {
    return Username;
  }

  String getPassword() {
    return Password;
  }
}
