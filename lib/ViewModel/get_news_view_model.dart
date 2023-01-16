import 'package:demo/apiModel/Repo/get_news_repo.dart';
import 'package:demo/apiModel/api_services/api_response.dart';
import 'package:demo/apiModel/model/ResponseModel/get_news_response_model.dart';
import 'package:get/get.dart';

class GetNewsViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getNewsApiResponse => _apiResponse;

  Future<void> getAllSportTypeViewModel({String? type}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetNewsResponseModel response =
          await GetNewsRepo().getNewsRepo(type: type);
      print('==GetNewsViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      _apiResponse = ApiResponse.error(message: e.toString());
      print("==GetNewsViewModel e => $e");
    }
    update();
  }
}
