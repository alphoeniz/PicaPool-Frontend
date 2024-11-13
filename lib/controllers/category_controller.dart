import 'dart:async';
import 'package:get/get.dart';
import 'package:picapool/services/categories/category_service.dart';
import 'package:picapool/services/categories/entities/category_entity.dart';


enum CategoriesState { loading, loaded, cantLoad }
enum IndividualCategoryState { loading, loaded, cantLoad }

class CategoryController extends GetxController {
  CategoriesState categoriesState = CategoriesState.loaded;
  IndividualCategoryState individualCategoryState = IndividualCategoryState.loaded;
  
  List<Category> categoryList = <Category>[];
  List<String> imageURLs = <String>[];

  /// Get all categories
  Future<void> getAllCategories() async {
    categoriesState = CategoriesState.loading;
    update();

    try {
      final List<Category> response = await CategoryServices.getAllCategories();
      if (response.isNotEmpty || response != []) {
        categoryList = response;
        // productsList = response.data ?? [];
       categoriesState = CategoriesState.loaded;
      } else {
       categoriesState = CategoriesState.cantLoad;
      }
    } catch (e) {
       categoriesState = CategoriesState.cantLoad;
      print('Error getting products list: $e');
    }
    update();
  }

}
