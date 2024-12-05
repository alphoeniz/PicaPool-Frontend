import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:picapool/core/core.dart';
import 'package:picapool/models/auth_model.dart';
import 'package:picapool/models/response_model.dart';
import 'package:picapool/models/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthApi {
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
        return right(Auth.fromJson(auth['data']));
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
        return right(Auth.fromJson(auth['data']));
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

  FutureEither<Auth> loginWithOtp(String mobile, String otp) async {
    const String url = 'https://api.picapool.com/v2/auth/login/User';

    var body = {
      'authInfo': {
        'msgOTP': {
          'mobile': mobile,
          'otp': otp,
        }
      }
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    log('OTP Sign-In Response: ${response.body}');

    final int statusCode = response.statusCode;

    debugPrint('OTP Sign-In Response Status Code: $statusCode');

    if (statusCode >= 200 && statusCode < 300) {
      var auth = jsonDecode(response.body);
      return right(Auth.fromJson(auth['data']));
    } else {
      return left(
        Failure(
            message: "Not able to sign in with otp : Status Code $statusCode",
            stackTrace: StackTrace.current),
      );
    }
  }

  FutureEither<User> createUser(User user, String accessToken) async {
    try {
      const String url = "https://api.picapool.com/v2/user";
      var body = {
        "name": user.name,
        "bio": user.bio,
        "pic": user.pic,
        "tagList": [],
      };
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      int statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        debugPrint('User Created: ${response.body}');
        var user = jsonDecode(response.body);
        return right(user);
      } else if (JwtDecoder.isExpired(accessToken)) {
        return left(
          Failure(
            message: "Access token expired",
            stackTrace: StackTrace.current,
          ),
        );
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

  // FutureEither<Auth> verifyOtp(String phoneNumber, String otp) async {
  //   String url =
  //       'https://api.picapool.com/v2/otp/verify?otp=$otp&mobile=${phoneNumber}';
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       final responseBody = response.body;
  //       if (responseBody.contains('"type":"success"')) {}
  //       // else {
  //       //   setState(() {
  //       //     _isOtpIncorrect = true;
  //       //   });

  //       //   ScaffoldMessenger.of(context).showSnackBar(
  //       //     const SnackBar(content: Text('Incorrect OTP. Please try again.')),
  //       //   );
  //       // }
  //     } else {
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //   const SnackBar(
  //       //       content: Text('Failed to verify OTP. Please try again.')),
  //       // );
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   const SnackBar(
  //     //       content: Text('An error occurred. Please try again later.')),
  //     // );
  //   }
  // }

  FutureEither<int> updateUser(
      Map<String, dynamic> updateValues, String accessToken) async {
    try {
      const String url = "https://api.picapool.com/v2/user/update";

      debugPrint("Updated Values: $updateValues");

      debugPrint("Access token : $accessToken");
      var body = {
        "user": {
          ...updateValues,
        }
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
        var json = jsonDecode(response.body);
        int success = json['data'];
        debugPrint("$success");
        return right(success);
      } else {
        debugPrint(
            'Update User Error: $statusCode with response ${response.body}');
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

  FutureEither<User> getUser(
      {required int userId, required String accessToken}) async {
    try {
      var response = await http.get(
        Uri.parse('https://api.picapool.com/v2/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );
      int statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode <= 300) {
        var responseModel = ResponseModel.fromJson(jsonDecode(response.body));
        debugPrint("getUser Response: ${response.body}");
        if (responseModel.success) {
          var user = User.fromJson(responseModel.data);
          return right(user);
        } else {
          return left(
            Failure(
              message: responseModel.message,
              stackTrace: StackTrace.current,
            ),
          );
        }
      } else {
        debugPrint(
          'Not able to get the user : status code $statusCode',
        );

        return left(
          Failure(
            message:
                "Not able to get the user : status code ${response.statusCode} with me",
            stackTrace: StackTrace.current,
          ),
        );
      }
    } catch (e) {
      debugPrint('Get User Error: $e');
      return left(
        Failure(
          message: "Not able to get the user : status code $e",
          stackTrace: StackTrace.current,
        ),
      );
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

  Future<String?> updateAccessToken({
    required String accessToken,
    required String refreshToken,
    required int userId,
  }) async {
    debugPrint('REQUESTED FOR UPDATE ACCESS TOKEN');
    debugPrint('Refresh token: $refreshToken');
    try {
      final response = await http.post(
        Uri.parse("https://api.picapool.com/v2/auth/accessToken"),
        body: jsonEncode({
          "refreshToken": refreshToken,
        }),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      debugPrint('UPDATE ACCESS TOKEN RESPONSE CODE : ${response.statusCode}');

      if (response.statusCode < 300) {
        String newAccessToken = response.body;
        debugPrint('New Access Token: $newAccessToken');
        return newAccessToken;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error updating access token: $e');
      return null;
    }
  }
}
