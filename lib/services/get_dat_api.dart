import '../data_model/data_model.dart';
import 'package:http/http.dart' as http;

class GetDataAPI {
 static Future<List<Brand>?> fetchData() async {
    String url =
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final String strBrand = response.body;
      return brandFromJson(strBrand);
    } else {
      // return response.statusCode;
    }
  }
}
