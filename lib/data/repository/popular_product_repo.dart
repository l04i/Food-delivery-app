import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
ApiClient apiClient;


  PopularProductRepo({ 
    required this.apiClient,
  });

Future<Response> getProductList()async{
return await apiClient.getData(AppConstants.popularURL);
}

}
