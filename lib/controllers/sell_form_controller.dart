import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picapool/controllers/product_controller.dart';
import 'package:picapool/widgets/sell/build_field.dart';

class FormController extends GetxController {
  static ProductController get productController => Get.find<ProductController>();
  // First Form Data
  var formOneData = <String, dynamic>{}.obs;

  // Second Form Data
  var formTwoData = <String, dynamic>{}.obs;

  // Function to save first form data
  void saveFormOneData(Map<String, dynamic> data) {
    formOneData.assignAll(data);
  }

  // Function to save second form data
  void saveFormTwoData(Map<String, dynamic> data) {
    formTwoData.assignAll(data);
  }

  void instantiateCreateProduct(BuildContext context){
    productController.createProduct(combinedFormData );
    if(productController.createProductState == CreateProductState.error){
      showSnackBar(content: "Oops! Error", context: context);
    }
  }

  // Function to get the combined data
  Map<String, dynamic> get combinedFormData {
    return {...formOneData, ...formTwoData};
  }
}
