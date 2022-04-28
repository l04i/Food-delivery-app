import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
ApiClient apiClient;


  RecommendedProductRepo({ 
    required this.apiClient,
  });

Future<Response> getProductList()async{
return await apiClient.getData(AppConstants.recommendedURL);
}

}
