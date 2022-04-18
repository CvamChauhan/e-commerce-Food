import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants
        .POPULAR_PRODUCT_URL); //only need endpoint here because getX get method only need endpoints not complete url
  }
}
