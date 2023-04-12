import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20), // 60 seconds,
      receiveTimeout: const Duration(seconds: 20), // 60 seconds
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print("this is the data: ${response.data.toString()}");
      return response.data['results'];
    } catch (error) {
      print("There was an error here: {$error}");
    }
    return [];
  }
}
