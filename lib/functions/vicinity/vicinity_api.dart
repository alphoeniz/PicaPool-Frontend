import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picapool/core/core.dart';
import 'package:path/path.dart' as path;
import 'package:picapool/functions/auth/auth_controller.dart';
import 'package:picapool/models/offer_model.dart';
import 'package:picapool/models/response_model.dart';
import 'package:picapool/models/vicinity_offer_model.dart';

class VicinityApiController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  String? get accessToken => authController.auth.value?.accessToken;

  FutureEither<VicinityOffer> createVicinity(
      {required VicinityOffer offer}) async {
    if (accessToken == null) {
      return left(
        Failure(
          message: "Access token is null",
          stackTrace: StackTrace.current,
        ),
      );
    }

    debugPrint(
        'Creating offer with access token $accessToken with offer : ${offer.toJson()}');
    var endpoint = "https://api.picapool.com/v2/offer";
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        body: jsonEncode(offer.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 401) {
        bool updated = await authController.updateAccessToken();
        if (updated) {
          return await createVicinity(
            offer: offer,
          );
        }
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var responseModel = ResponseModel.fromJson(jsonDecode(response.body));
        if (responseModel.success) {
          var offerResponse = VicinityOffer.fromJson(responseModel.data);
          return right(offerResponse);
        } else {
          return left(Failure(
            message: responseModel.message,
            stackTrace: StackTrace.fromString(response.body),
          ));
        }
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

  FutureEither<String> uploadImageToServer(
      XFile? pickedFile, String uname, String offername) async {
    if (pickedFile == null) {
      return left(Failure(
          message: "No image selected", stackTrace: StackTrace.current));
    }
    try {
      final auth = authController.auth.value;
      if (auth == null) {
        left(Failure(
          message: "Auth is null",
          stackTrace: StackTrace.current,
        ));
      }
      String at = authController.auth.value!.accessToken!;
      debugPrint("Uploading image to server at : $at");
      Uri endpoint = Uri.parse('https://api.picapool.com/v2/s3/upload');

      MediaType? contentType;
      String? ext = path.extension(pickedFile.path).toLowerCase();
      debugPrint("Uploading image to server ext : $ext");
      if (ext == '.jpg' || ext == '.jpeg') {
        contentType = MediaType('image', 'jpeg');
      } else if (ext == '.png') {
        contentType = MediaType('image', 'png');
      }
      debugPrint("Uploading image to server content type : $contentType");
      var request = http.MultipartRequest('POST', endpoint);
      String fileName = path.basename(pickedFile.path);

      debugPrint("Uploading image to server fileName : $fileName");

      request.fields['key'] = 'images/pool/$fileName';

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        pickedFile.path,
        contentType: contentType,
        filename: '$uname-$offername-${DateTime.now().toIso8601String()}.jpg',
      ));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $at',
      });

      var response = await request.send();

      if (response.statusCode < 300) {
        var responseModel = ResponseModel.fromJson(
            jsonDecode(await response.stream.bytesToString()));
        if (!responseModel.success) {
          return left(
            Failure(
                message: responseModel.message, stackTrace: StackTrace.current),
          );
        }

        var url = responseModel.data['url'];
        debugPrint(
            "Uploading image to server response : ${responseModel.data} with url : $url");
        return right(url);
      } else if (response.statusCode == 401) {
        bool response = await authController.updateAccessToken();
        if (response) {
          return await uploadImageToServer(pickedFile, uname, offername);
        }
      } else {
        debugPrint("$response");
        debugPrint('Upload failed with status code: ${response.statusCode}');
        return left(Failure(
          message: "Failed to upload image",
          stackTrace: StackTrace.fromString(response.toString()),
        ));
      }
    } catch (e) {
      return left(Failure(
          message: "Failed to upload image", stackTrace: StackTrace.current));
    }

    return left(
      Failure(
          message: "Failed to upload image", stackTrace: StackTrace.current),
    );
  }

  FutureEither<List<VicinityOffer>> searchVicinity() async {
    throw UnimplementedError();
  }
}

String getFileName(String filePath) {
  return path.basename(filePath);
}
