import 'package:food_delivery/data/models/response_model.dart';
import 'package:food_delivery/data/models/sign_up_body_model.dart';
import 'package:food_delivery/data/models/user_model.dart';
import 'package:food_delivery/data/repository/user_repo.dart';
import 'package:get/get.dart';

import 'package:food_delivery/data/repository/auth_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isloading = false;
  bool get isloading => _isloading;
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserData() async {
    _isloading = true;
    

    ResponseModel responseModel;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);

      responseModel = ResponseModel(isSuccess: true, message: "Successfully");
    } else {
      responseModel =
          ResponseModel(isSuccess: false, message: response.statusText);
    }
    _isloading = false;
    update();
    return responseModel;
  }
}
