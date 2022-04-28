import 'package:food_delivery/data/models/sign_up_body_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_delivery/data/api/api_client.dart';

class AuthRepo {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
        AppConstants.loginURL, {'email': email, "password": password});
  }

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstants.registrationURL, signUpBody.toJson());
  }

  Future<bool> saveUserToken(String token) async{
    apiClient.token = token;
    apiClient.updateHeaders(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<String> getUserToken()async{
    return await sharedPreferences.getString(AppConstants.token)??'none';
  }

  bool isUserLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<void> saveEmailAndPassword(String email,String password)async{

    try{
 await sharedPreferences.setString(AppConstants.email, email);
 await sharedPreferences.setString(AppConstants.password, password);
    }
   catch(e){
rethrow;
   }
  }

  bool clearSharedDate(){
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.email);
    sharedPreferences.remove(AppConstants.password);
    apiClient.token = "";
    apiClient.updateHeaders("");
    
    return true;
  }
}
