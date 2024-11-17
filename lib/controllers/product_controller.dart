import 'dart:async';
import 'package:get/get.dart';
import 'package:picapool/services/products/payloads/create_product_payload.dart';
import 'package:picapool/services/products/payloads/update_product_payload.dart';
import 'package:picapool/services/products/responses/create_product_response.dart';
import 'package:picapool/services/products/entities/product_entity.dart';
import 'package:picapool/services/products/products_service.dart';
import 'package:picapool/services/products/responses/get_all_products_response.dart';
import 'package:picapool/services/products/responses/update_product_response.dart';

enum ProductsState { productsLoading, productsLoaded, productsCantLoad }
enum CreateProductState { creating, created, error }
enum IndividualProductsState { productsLoading, productsLoaded, productsCantLoad }

class ProductController extends GetxController {
  ProductsState productsState = ProductsState.productsLoaded;
  CreateProductState createProductState = CreateProductState.created;
  IndividualProductsState individualProductsState = IndividualProductsState.productsLoading;
  
  List<Product> productsList = <Product>[];
  List<String> imageURLs = <String>[];
  int currentIndex = 1;

  /// Get all products
  Future<void> getAllProducts() async {
    productsState = ProductsState.productsLoading;
    update();

    try {
      final List<Product> response = await ProductsServices.getAllProducts();
      if (response.isNotEmpty || response != []) {
        productsList = response;
        // productsList = response.data ?? [];
        productsState = ProductsState.productsLoaded;
      } else {
        productsState = ProductsState.productsCantLoad;
      }
    } catch (e) {
      productsState = ProductsState.productsCantLoad;
      print('Error getting products list: $e');
    }
    update();
  }

  /// Create a new product
  Future<void> createProduct(Map<String, dynamic> createProductPayload) async {
    createProductState = CreateProductState.creating;
    update();

    final CreateProductResponse response = await ProductsServices.createProduct(createProductPayload);
    if (response.success ?? false) {
      createProductState = CreateProductState.created;
      await getAllProducts();  // Refresh the products list after creation
    } else {
      createProductState = CreateProductState.error;
    }
    update();
  }

  /// Update an existing product
  Future<void> updateProduct(String productId, UpdateProductPayload updateProductPayload) async {
    individualProductsState = IndividualProductsState.productsLoading;
    update();

    try {
      final UpdateProductResponse response = await ProductsServices.updateProduct(productId, updateProductPayload);
      if (response.success ?? false) {
        individualProductsState = IndividualProductsState.productsLoaded;
        await getAllProducts();  // Refresh the products list after updating
      } else {
        individualProductsState = IndividualProductsState.productsCantLoad;
      }
    } catch (e) {
      individualProductsState = IndividualProductsState.productsCantLoad;
      print('Error updating product: $e');
    }
    update();
  }

  /// Delete a product
  // Future<void> deleteProduct(String productId) async {
  //   individualProductsState = IndividualProductsState.productsLoading;
  //   update();

  //   try {
  //     final CreateProductResponse response = await ProductsServices.deleteProduct(productId);
  //     if (response.success ?? false) {
  //       individualProductsState = IndividualProductsState.productsLoaded;
  //       await getAllProducts();  // Refresh the products list after deletion
  //     } else {
  //       individualProductsState = IndividualProductsState.productsCantLoad;
  //     }
  //   } catch (e) {
  //     individualProductsState = IndividualProductsState.productsCantLoad;
  //     print('Error deleting product: $e');
  //   }
  //   update();
  // }
}
