import 'dart:convert';
import 'dart:developer';
import 'package:demo/apiModel/api_services/api_routes.dart';
import 'package:demo/apiModel/api_services/api_service.dart';
import 'package:demo/apiModel/model/ResponseModel/get_news_response_model.dart';

class GetNewsRepo extends ApiRoutes {
  Future<dynamic> getNewsRepo({String? type}) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: getNews + type!);

    log('GetNewsRepo ----------- ${jsonEncode(response)}');
    print('GetNewsRepo ----------- ${getNews + type} ');

    GetNewsResponseModel getNewsResponseModel =
        GetNewsResponseModel.fromJson(response);
    return getNewsResponseModel;
  }
}
