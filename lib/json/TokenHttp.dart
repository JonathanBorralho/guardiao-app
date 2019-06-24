import 'package:http/http.dart' as Http;
import 'package:guardiao_mobile/service/AuthService.dart';
import 'package:guardiao_mobile/model/Auth.dart';
import 'package:http/src/response.dart';


class TokenHttp{

  final AuthService authService       = new AuthService();

  Future<Response> get(String url) async{
    Auth auth  = await authService.getOnlyOneAuth();
    var header = {"Authorization": auth.token};

    Http.get(url, headers: header).then((response) {
      if (response.statusCode == 200) {
        
      }

    });


    return Http.get(url, headers: header);
  }

  Future<Response> post(String url, body) async{
    Auth auth  = await authService.getOnlyOneAuth();
    var header = {"Authorization": auth.token};
    return Http.post(url, headers: header, body: body);
  }

}