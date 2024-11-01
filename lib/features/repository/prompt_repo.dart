import 'dart:io';

import 'package:dio/dio.dart';

class PromptRepository{
  static Future<File?>generateImage(String prompt) async{
    String url = 'https://api.vyro.ai/v1/imagine/api/generation';

    Map<String, dynamic> headers = {
      "Authorization": "Bearer 	vk-eCBXyPIbJkSAKiXPmfD8EI9wFtweezlDl61xh7G215836z"
    };

    Map<String, dynamic> payload = {
      'prompt': prompt,
      'style_id': '122',
      'aspect_ratio': '1:1',
      'cfg': '5',
      'seed': '1',
      'high_res_results': '1'
    };

    Dio dio = Dio();
    dio.options = BaseOptions(
      headers: headers
    );

    final response = await dio.post(
      url, data: payload
    );

    if(response.statusCode == 200){
      File file = File("image.jpg");
      file.writeAsBytesSync(response.data);
      return file;
    }
    return null;
  }
}

// let headers = new Headers();
// headers.append();
//
// let formdata = new FormData();
// formdata.append("style_id", "29");
// formdata.append("aspect_ratio", "16:9");
// formdata.append("cfg", "7");
// formdata.append("seed", "1");
//
// let requestOptions = {
// method: 'POST',
// body: formdata,
// headers: headers,
// };
//
// fetch("https://api.vyro.ai/v1/imagine/api/generations", requestOptions)
//     .then(response => response.text())
//     .then(result => console.log(result))
//     .catch(error => console.log('error', error));