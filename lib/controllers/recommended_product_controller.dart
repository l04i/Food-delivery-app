
import 'package:food_delivery/data/models/products_model.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

import 'package:food_delivery/data/repository/popular_product_repo.dart';

class RecommendedProductController extends GetxController  {
  RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({
    required this.recommendedProductRepo,
  });
  List<dynamic> _recommendedProduct = [];
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  List<dynamic> get recommendedProduct => _recommendedProduct;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getProductList();
    if (response.statusCode == 200) {
      _recommendedProduct = [];
      _recommendedProduct.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      Get.snackbar("Error", "Can'\t get products");
    }
  }
}
