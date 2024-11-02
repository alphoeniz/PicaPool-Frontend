import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:picapool/core/core.dart';
import 'package:picapool/functions/auth/auth_controller.dart';
import 'package:picapool/models/offer_model.dart';

class VicinityApiController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  String? get accessToken => authController.state.value.auth?.accessToken;

  FutureEither<Offer> createVicinity({
    required Map<String, dynamic> offer,
    required int destination,
    required String userId,
  }) async {
    if (accessToken == null) {
      return left(
        Failure(
          message: "Access token is null",
          stackTrace: StackTrace.current,
        ),
      );
    }

    debugPrint('Creating offer with access token $accessToken');
    var endpoint = "https://api.picapool.com/v2/offer";
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        body: jsonEncode({
          'offerData': offer.toString(),
          'userId': userId,
          'dist': destination,
          'name': offer['name']
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 401) {
        // Handle token expiration if necessary
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var offerResponse = Offer.fromJson(jsonDecode(response.body));
        return right(offerResponse);
      } else {
        return left(Failure(
          message: "Failed to create offer",
          stackTrace: StackTrace.fromString(response.body),
        ));
      }
    } catch (err) {
      debugPrint('Error uploading offer to server: $err');
      return left(Failure(
        message: "Failed to create offer",
        stackTrace: StackTrace.fromString(err.toString()),
      ));
    }
  }

  FutureEither<Offer> getVicinity(int offerId) async {
    throw UnimplementedError();
  }

  FutureEither<List<Offer>> searchVicinity() async {
    throw UnimplementedError();
  }
}
