import 'dart:core';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:picapool/utils/logger_helper.dart';

// TODO: Implement Local storage 
final GetStorage box = GetStorage();

Future<void> saveAccessToken(String accessToken) async {
  try {
    await box.write('accessToken', accessToken);
  } catch (e) {
    logger.printInfo(info: e.toString());
  }
}

Future<void> saveRefreshToken(String refreshToken) async {
  try {
    await box.write('refreshToken', refreshToken);
  } catch (e) {
    logger.printInfo(info: e.toString());
  }
}

Future<void> removeToken(String token) async {
  try {
    await box.remove(token);
  } catch (e) {
    logger.printInfo(info: e.toString());
  }
}

String? getToken(String tokenName) {
  try {
    // final String? token = box.read(tokenName);
    final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoSWQiOjEsInRlbmFudCI6eyJ0eXBlIjoiVXNlciIsImlkIjoxMDF9LCJSb2xlcyI6W3siaWQiOjEsInJvbGUiOiJVc2VyIn1dLCJpYXQiOjE3MzA1NTY3MDIsImV4cCI6MTczMDY0MzEwMn0.5v2j7-sAFqBMS3hAb6sAyJyv2z3ibRjFDh74J1Scaos";
    return token;
  } catch (e) {
    logger.printInfo(info: e.toString());
    return null;
  }
}

bool? isTokenExpired(String tokenName) {
  final String? token = getToken(tokenName);
  {
    if (token != null) {
      if (Jwt.isExpired(token)) {
        return true;
      } else {
        return false;
      }
    }
    return null;
  }
}

Future<String?> getAccessToken() async {
  try {
    // TODO: Merge from Krishna's auth code
    // hardcoding for now
    final String? accessToken =   "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoSWQiOjEsInRlbmFudCI6eyJ0eXBlIjoiVXNlciIsImlkIjoxMDF9LCJSb2xlcyI6W3siaWQiOjMsInJvbGUiOiJVc2VyIn1dLCJpYXQiOjE3MzA0NjU5MzMsImV4cCI6MTczMDU1MjMzM30.4HmGRryCAUWUZuUTQuCk36lfa1HJDNmcD4a_LNoTskk";
    // final String? token = getToken('accessToken');
    // if (token != null) {
    //   if (!Jwt.isExpired(token)) {
    //     return true;
    //   } else {
    //     final RefreshTokenResponse response =
    //         await AuthServices.refreshTokenService();
    //     if (response.success) {
    //       await saveAccessToken(response.data!.accessToken);
    //       await saveRefreshToken(response.data!.refreshToken);
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   }
    // }
    return accessToken;
  } catch (e) {
    logger.printInfo(info: e.toString());
    return null;
  }
}

Future<void> rememberMe(bool? value) async {
  try {
    if (value!) {
      await box.write('rememberMe', true);
    } else {
      await box.write('rememberMe', false);
    }
  } catch (e) {
    logger.printInfo(info: e.toString());
  }
}

bool? checkRememberMe() {
  try {
    final bool? value = box.read('rememberMe');
    if (value != null) {
      if (value) {
        return value;
      } else {
        return value;
      }
    } else {
      return null;
    }
  } catch (e) {
    logger.printInfo(info: e.toString());
    return null;
  }
}

Future<void> initialOpen(bool newStart) async {
  try {
    await box.write('freshStart', newStart);
  } catch (e) {
    logger.printInfo(info: e.toString());
  }
}

bool readUser() {
  try {
    final bool? use = box.read('freshStart');
    if (use != null) {
      return true;
    }
    return false;
  } catch (e) {
    logger.printInfo(info: e.toString());
    return false;
  }
}

Future<void> storeResentSearch(List<String> searchTexts) async {
  await box.write('searchList', searchTexts);
}

List<String>? getResentSearches() {
  try {
    final Iterable<dynamic> list = box.read('searchList') as Iterable<dynamic>;
    return List<String>.from(list);
  } catch (e) {
    return null;
  }
}
