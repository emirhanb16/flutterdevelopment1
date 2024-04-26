// ignore_for_file:empty_catches

import 'package:dio/dio.dart';

class API {
  final dio = Dio();
  final String baseUrl = "https://reqres.in/api";

  Future<Map<String, dynamic>> getUsers({int page = 1}) async {
    try {
      final String url =
          "$baseUrl/users?page=$page"; // sayfa parametresi eklendi
      Response response = await dio.get(url);

      // Burada API'den gelen veriyi kontrol edebilir ve döndürebilirsiniz.
      // Örneğin, hata durumunu kontrol etmek için:
      // Bu sayfa responsivedir.
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      // Hata durumunda burası çalışacak
      // Hata bilgileri de e değişkeninin içerisinde olacak
      return {"error": e.toString()};
    }
  }

  loginUser({required String username, required String password}) async {
    try {
      final String url = "https://key1.tech/api/login";
      final parameters = {"email": username, "password": password};
      final response = await dio.post(
        url,
        data: FormData.fromMap(parameters),
      );

      // Burada API'den gelen veriyi kontrol edebilir ve döndürebilirsiniz.
      return response.data;
    } catch (e) {
      // Hata durumunda burası çalışacak
      // Hata bilgileri de e değişkeninin içerisinde olacak
      return {"error": e.toString()};
    }
  }

  createUser() {}

  login({required String username, required String password}) {}
}

void loginUser({required String username, required String password}) {}
