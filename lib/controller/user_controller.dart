import 'package:food_delivery/data/repository/user_repo.dart';
import 'package:food_delivery/helper/models/response_model.dart';
import 'package:food_delivery/helper/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      update();
      responseModel = ResponseModel(true, 'successfully');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
