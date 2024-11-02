import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:picapool/core/core.dart';
import 'package:picapool/models/auth_model.dart';
import 'package:picapool/models/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class IAuthApi {
  FutureEither<Auth> signInWithGoogle();
  FutureEither<Auth> signInWithApple();
  FutureEither<User> createUser(User user, String accessToken);
  FutureVoid updateUser(Map<String, dynamic> updateValues, String accessToken,
      {required int id});

  FutureVoid getUser(int id, String accessToken);
}

class AuthApi implements IAuthApi {
  @override
  FutureEither<Auth> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['profile', 'email'],
      forceCodeForRefreshToken: true,
    );
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account == null) {
        throw Exception('No account found');
      }

      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      log('Google Token: ${googleAuth.idToken}');

      final http.Response response =
          await _sendGoogleTokenToServer(googleAuth.idToken!);

      final int statusCode = response.statusCode;

      debugPrint('Google Sign-In Response Status Code: $statusCode');

      if (statusCode >= 200 && statusCode < 300) {
        var auth = jsonDecode(response.body);
        return right(Auth.fromJson(auth));
      } else {
        return left(
          Failure(
              message:
                  "Not able to sign in with google : Status Code $statusCode",
              stackTrace: StackTrace.current),
        );
      }
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      return left(
        Failure(
          message: "Failed to sign in with Google. Please try again.",
          stackTrace: StackTrace.fromString(e.toString()),
        ),
      );
    }
  }

  @override
  FutureEither<Auth> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      log('Apple Token: ${appleCredential.identityToken}');

      final http.Response response =
          await _sendAppleTokenToServer(appleCredential.identityToken!);

      final int statusCode = response.statusCode;

      debugPrint('Apple Sign-In Response Status Code: $statusCode');

      if (statusCode >= 200 && statusCode < 300) {
        var auth = jsonDecode(response.body);
        return right(Auth.fromJson(auth));
      } else {
        return left(
          Failure(
              message:
                  "Not able to sign in with apple : status code $statusCode",
              stackTrace: StackTrace.current),
        );
      }
    } catch (e) {
      return left(
        Failure(
            message: "Failed to sign in with Apple. Please try again.",
            stackTrace: StackTrace.fromString(e.toString())),
      );
    }
  }

  // Future<void> sendOtp(String phoneNumber) async {
  //   final String url = 'https://api.picapool.com/v2/otp?mobile=$phoneNumber';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json'},
  //       body: '{}', // Sending an empty JSON object as the body
  //     );

  //     debugPrint('Status Code: ${response.statusCode}');
  //     debugPrint('Response: ${response.body}');

  //     if (response.statusCode == 201) {
  //       Get.to(() => OtpScreen(phoneNumber: phoneNumber));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text('Failed to send OTP. Please try again.')),
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text('An error occurred. Please try again later.')),
  //     );
  //   }
  // }

  Future<http.Response> _sendGoogleTokenToServer(String googleToken) async {
    const String url = 'https://api.picapool.com/v2/auth/login/User';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: '{"authInfo": {"googleToken": "$googleToken", "appleToken": ""}}',
    );

    log('Google Sign-In Response: ${response.body}');

    return response;
  }

  Future<http.Response> _sendAppleTokenToServer(String appleToken) async {
    const String url = 'https://api.picapool.com/v2/auth/login/User';

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: '{"authInfo": {"appleToken": "$appleToken"}}',
    );

    log('Apple Sign-In Response: ${response.body}');

    return response;
  }

  @override
  FutureEither<User> createUser(User user, String accessToken) async {
    try {
      const String url = "https://api.picapool.com/v2/user";
      var body = {
        "name": user.name,
        "bio": user.bio,
        "pic": user.pic,
        "tagList": [],
        "accessToken": accessToken,
      };
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      int statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        debugPrint('User Created: ${response.body}');
        var user = jsonDecode(response.body);
        return right(user);
      } else {
        return left(
          Failure(
            message: "Not able to create the user : status code $statusCode",
            stackTrace: StackTrace.current,
          ),
        );
      }
    } catch (e) {
      debugPrint('Create User Error: $e');
      return left(
        Failure(
          message: "Failed to create user. Please try again.",
          stackTrace: StackTrace.fromString(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  FutureEither<int> updateUser(
      Map<String, dynamic> updateValues, String accessToken,
      {required int id}) async {
    try {
      const String url = "https://api.picapool.com/v2/user/update";

      getUser(id, accessToken);

      debugPrint("Updated Values: $updateValues");

      debugPrint("Access token : $accessToken");
      var body = {
        "user": {...updateValues}
      };

      debugPrint(body.toString());

      http.Response response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(body),
      );
      int statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        debugPrint('User Updated: ${response.body}');
        getUser(id, accessToken);
        int success = jsonDecode(response.body);
        debugPrint("$success");
        return right(success);
      } else {
        debugPrint('Update User Error: $statusCode');
        return left(
          Failure(
            message: "Not able to create the user : status code $statusCode",
            stackTrace: StackTrace.current,
          ),
        );
      }
    } catch (e) {
      debugPrint('Update User Error: $e');
      return left(
        Failure(
          message: "Failed to create user. Please try again.",
          stackTrace: StackTrace.fromString(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  FutureVoid getUser(int id, String accessToken) async {
    try {
      var response = await http.get(
        Uri.parse('https://api.picapool.com/v2/user/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );
      int statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode <= 300) {
        var user = jsonDecode(response.body);
        debugPrint('User: $user');
      } else {
        debugPrint(
          'Not able to get the user : status code $statusCode',
        );

        // left(
        //   Failure(
        //     message: "Not able to get the user : status code $response",
        //     stackTrace: StackTrace.current,
        //   ),
        // );
      }
    } catch (e) {
      debugPrint('Get User Error: $e');
    }
  }

  // FutureEither<String> refreshAccessToken(String refreshToken) {
  //   try {
  //     const String url = "https://api.picapool.com/v2/auth/refresh";
  //     var body = {
  //       "refreshToken": refreshToken,
  //     };
  //     http.Response response = await http.post(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(body),
  //     );
  //     int statusCode = response.statusCode;
  //     if (statusCode >= 200 && statusCode < 300) {
  //       debugPrint('User Created: ${response.body}');
  //       var user = jsonDecode(response.body);
  //       return right(user);
  //     } else {
  //       return left(
  //         Failure(
  //           message: "Not able to create the user : status code $statusCode",
  //           stackTrace: StackTrace.current,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint('Create User Error: $e');
  //     return left(
  //       Failure(
  //         message: "Failed to create user. Please try again.",
  //         stackTrace: StackTrace.fromString(e.toString()),
  //       ),
  //     );

  // }
}
