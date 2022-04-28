import 'package:food_delivery/data/models/response_model.dart';
import 'package:food_delivery/data/models/sign_up_body_model.dart';
import 'package:get/get.dart';

import 'package:food_delivery/data/repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });
  
  bool _isloading = false;
  bool get isloading => _isloading;


  Future<ResponseModel> login(String email , String password)async{

    
    _isloading=true;
    update();
    ResponseModel responseModel;
Response response = await authRepo.login(email, password);
if(response.statusCode==200){

  print(response.body['token']);
authRepo.saveUserToken(response.body['token']);print(response.body);
responseModel = ResponseModel(isSuccess: true, message: response.body['token']);
}
else{
 
responseModel= ResponseModel(isSuccess: false, message: response.statusText);
}
_isloading = false;
update();
return responseModel;
  }
  

  Future<ResponseModel> registration(SignUpBody signUpBody)async{
  _isloading = true;
  update();
  ResponseModel responseModel;
Response response = await authRepo.registration(signUpBody);
if(response.statusCode==200){
authRepo.saveUserToken(response.body['token']);
responseModel = ResponseModel(isSuccess: true, message: response.body['token']);
}
else{
responseModel= ResponseModel(isSuccess: false, message: response.statusText);
}
_isloading = false;
update();
return responseModel;
  
  }

    void saveEmailrAndPassword(String email,String password)async{
    await authRepo.saveEmailAndPassword(email, password);
    }

      bool isUserLoggedIn(){
return authRepo.isUserLoggedIn();
  }

  void clearSharedData(){
    authRepo.clearSharedDate();
  }
}
