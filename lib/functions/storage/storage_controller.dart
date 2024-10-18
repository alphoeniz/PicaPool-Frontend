import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picapool/models/auth_model.dart';
import 'package:picapool/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final storageProvider = StateNotifierProvider<StorageController, StorageState>(
  (ref) => StorageController(),
);

class StorageState {
  final User? user;
  final Auth? auth;

  StorageState({this.user, this.auth});

  StorageState copyWith({User? user, Auth? auth}) {
    return StorageState(
      user: user ?? this.user,
      auth: auth ?? this.auth,
    );
  }

  bool get hasAuth => auth != null && auth!.accessToken != null;

  bool get hasUser => user != null;
}

class StorageController extends StateNotifier<StorageState> {
  StorageController() : super(StorageState()) {
    loadAuth();
    loadUser();
  }

  /// Saves the authentication information (Auth) to SharedPreferences.
  Future<void> saveAuth(Auth auth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authData = jsonEncode(auth.toJson());
    await prefs.setString('auth', authData);
    state = state.copyWith(auth: auth, user: auth.user);
  }

  /// Loads the authentication information (Auth) from SharedPreferences.
  Future<void> loadAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authData = prefs.getString('auth');
    if (authData != null) {
      Map<String, dynamic> authMap = jsonDecode(authData);
      Auth auth = Auth.fromJson(authMap);
      state = state.copyWith(auth: auth, user: auth.user);
    }
  }

  /// Clears the authentication information from SharedPreferences.
  Future<void> clearAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth');
    state = state.copyWith(auth: null, user: null);
  }

  /// Saves the user data to SharedPreferences.
  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = jsonEncode(user.toJson());
    await prefs.setString('user', userData);
    state = state.copyWith(user: user);
  }

  /// Loads the user data from SharedPreferences.
  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      User user = User.fromJson(userMap);
      state = state.copyWith(user: user);
    }
  }

  /// Clears the user data from SharedPreferences.
  Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    state = state.copyWith(user: null);
  }
}
