import 'package:get/get.dart';
import 'package:picapool/controllers/product_controller.dart';

class ProductBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
  }
}
