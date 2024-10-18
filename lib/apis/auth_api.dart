import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:picapool/core/core.dart';
import 'package:picapool/models/auth_model.dart';

abstract class IAuthApi {
  FutureEither signInWithGoogle();
  FutureEither signInWithApple();
  FutureEither logout();
}

class AuthApi implements IAuthApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  FutureEither logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  FutureEither signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  FutureEither signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
